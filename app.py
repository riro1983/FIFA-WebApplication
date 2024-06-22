from flask import Flask,request,jsonify,redirect,url_for,render_template
from flask_cors import CORS
import sqlite3

app = Flask(__name__, static_folder='frontend/static', template_folder='frontend/templates')

CORS(app, resources={r"/*": {"origins": "http://127.0.0.1:5500"}})

@app.route('/')
def index():
    return render_template('app.html')


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    print(f"login attempt: {username},{password}")
    if username and password:
        conn = sqlite3.connect('database/fut.db')
        c = conn.cursor()
        query = "SELECT * FROM Users WHERE u_name = ? AND u_pass = ?"
        c.execute(query, (username, password))
        user = c.fetchone()
        conn.close()
        print(user)
        if user:
            return jsonify(message='Login Successful'),200
        else:
            return jsonify(message='Login Failed'),400
    return render_template('index')

@app.route('/register', methods=['POST'])
def register():
    data = request.json
    new_username = data.get('newUsername')
    new_password = data.get('newPassword')

    if new_username and new_password:
        conn = sqlite3.connect('database/fut.db')
        c = conn.cursor()
        query = "INSERT INTO Users (u_name, u_pass) VALUES (?, ?)"
        c.execute(query, (new_username, new_password))
        conn.commit()
        conn.close()
        return jsonify(message='Registration Successful'),200
    return jsonify(message='Invalid registration data'),400

@app.route('/search')
def search():
    username = request.args.get('username')
    return render_template('search.html',username=username)

@app.route('/savedsquads')
def savedsquads():
    username = request.args.get('username')
    return render_template('saved_squads.html',username=username)

@app.route('/get_squads', methods=['GET'])
def get_squads():
    username = request.args.get('username')
    print(username)
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    user_query = "SELECT u_id FROM Users WHERE u_name = ?"
    c.execute(user_query,(username,))
    user_id = c.fetchone()[0]
    squads_query = "SELECT * FROM SavedSquad WHERE u_id = ?"
    c.execute(squads_query,(user_id,))
    squads = c.fetchall()
    conn.close()
    print(squads)
    return render_template('saved_squads.html',username=username,squads=squads)

@app.route('/get_formations',methods=['GET'])
def get_formations():
    username = request.args.get('username')
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    formations_query = "SELECT f_name FROM Formation"
    c.execute(formations_query)
    formations = [formation[0] for formation in c.fetchall()]
    conn.close()
    return render_template('create_squad.html',formations=formations,username=username)

@app.route('/view_squad/<int:squad_id>', methods=['GET'])
def view_squad(squad_id):
    username = request.args.get('username')
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    
    squad_query = "SELECT * FROM SavedSquad WHERE ss_id = ?"
    c.execute(squad_query, (squad_id,))
    squad_details = c.fetchone()
    formation_query = "SELECT f_name FROM SavedSquad JOIN Formation ON SavedSquad.f_id = Formation.f_id WHERE SavedSquad.ss_id = ?"
    c.execute(formation_query,(squad_id,))
    formation_name = c.fetchone()[0]

    players_query = """
        SELECT Players.p_id, Players.p_name, Players.p_club, Players.p_league,
               Players.p_nation, Players.p_rating, Players.p_position
        FROM Players
        JOIN PlayersInSquad ON Players.p_id = PlayersInSquad.p_id
        WHERE PlayersInSquad.ss_id = ?
    """
    c.execute(players_query, (squad_id,))
    players = c.fetchall()

    conn.close()
    return render_template('view_squad.html', squad=squad_details, players=players, username=username,formation_name=formation_name)

    
@app.route('/createsquad',methods=['POST'])
def create_squad():
    data = request.json
    username = data.get('username')
    formation = data.get('formation')
    print(username)
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    user_query = "SELECT u_id FROM Users WHERE u_name = ?"
    c.execute(user_query,(username,))
    user_id = c.fetchone()
    if user_id is not None:
        user_id = user_id[0]
    else:
        print("User not found")
    print(user_id)
    formation_query = "SELECT f_id FROM Formation WHERE f_name = ?"
    c.execute(formation_query, (formation,))
    formation_id = c.fetchone()

    if formation_id is not None:
        formation_id = formation_id[0]
    else:
        print("Formation not found")

    squad_query = "INSERT INTO SavedSquad (u_id,f_id) VALUES (?,?)"
    c.execute(squad_query,(user_id,formation_id))
    conn.commit()
    conn.close()
    return jsonify(message='Squad created!'),200

@app.route('/dashboard')
def dashboard():
    username = request.args.get('username')
    return render_template('dashboard.html',username=username)

@app.route('/players',methods=['GET'])
def search_players():
    player_name = request.args.get('playerName')
    position = request.args.get('position')
    club = request.args.get('club')
    league = request.args.get('league')
    nation = request.args.get('nation')
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    query = "SELECT * FROM Players WHERE 1=1"

    if player_name:
        query += f" AND p_name LIKE '%{player_name}%'"
    if position:
        query += f" AND p_position LIKE '{position}'"
    if club:
        query += f" AND p_club LIKE '{club}'"
    if league:
        query += f" AND p_league LIKE '{league}'"
    if nation:
        query += f" AND p_nation LIKE '{nation}'"
    c.execute(query)
    columns = [col[0] for col in c.description]
    results = [dict(zip(columns,row)) for row in c.fetchall()]
    c.close()
    return jsonify(results)

@app.route('/add_to_squad', methods=['POST'])
def add_to_squad():
    data = request.json
    squad_id = data.get('squadId')
    player_id = data.get('playerId')

    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()

    check_query = "SELECT * FROM PlayersInSquad WHERE p_id = ? AND ss_id = ?"
    c.execute(check_query, (player_id, squad_id))
    existing_entry = c.fetchone()

    if existing_entry:
        conn.close()
        return jsonify(message=f'Player is already in the squad {squad_id}'), 200

    insert_query = "INSERT INTO PlayersInSquad (p_id, ss_id) VALUES (?, ?)"
    c.execute(insert_query, (player_id, squad_id))
    conn.commit()
    conn.close()

    return jsonify(message=f'Player added to squad {squad_id} successfully'), 200

@app.route('/delete_player', methods=['DELETE'])
def delete_player():
    data = request.json
    squad_id = data.get('squadID')
    player_id = data.get('playerID')
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    delete_query = "DELETE FROM PlayersInSquad WHERE p_id = ? AND ss_id = ?"
    c.execute(delete_query, (player_id, squad_id))
    conn.commit()
    return jsonify(message='Player deleted successfully'), 200

@app.route('/delete_squad', methods=['DELETE'])
def delete_squad():
    data = request.json
    squad_id = data.get('squadID')
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()
    delete_query = "DELETE FROM SavedSquad WHERE ss_id = ?"
    c.execute(delete_query, (squad_id,))
    conn.commit()
    return jsonify(message='Squad deleted successfully'), 200


@app.route('/get_squad_summary/<int:squad_id>', methods=['GET'])
def get_squad_summary(squad_id):
    conn = sqlite3.connect('database/fut.db')
    c = conn.cursor()

    avg_stats_query = """
        SELECT AVG(Pace_Diving) AS avg_pace_diving,
               AVG(Shooting_Handling) AS avg_shooting_handling,
               AVG(Passing_Kicking) AS avg_passing_kicking,
               AVG(Dribbling_Reflexes) AS avg_dribbling_reflexes,
               AVG(Defense_Speed) AS avg_defense_speed,
               AVG(Physical_Positioning) AS avg_physical_positioning
        FROM PerformanceMetric
        JOIN PlayersInSquad ON PerformanceMetric.p_id = PlayersInSquad.p_id
        JOIN SavedSquad ON PlayersInSquad.ss_id = SavedSquad.ss_id
        WHERE SavedSquad.ss_id = ?;
    """
    c.execute(avg_stats_query, (squad_id,))
    result = c.fetchone()
    conn.close()
    if result:
        avg_stats = {
            'avg_pace_diving': result[0],
            'avg_shooting_handling': result[1],
            'avg_passing_kicking': result[2],
            'avg_dribbling_reflexes': result[3],
            'avg_defense_speed': result[4],
            'avg_physical_positioning': result[5],
        }
        return jsonify(avg_stats), 200
    else:
        return jsonify({'error':'No Data'}),400

if __name__ == '__main__':
    app.run(debug=True,host='127.0.0.1', port=5000)
