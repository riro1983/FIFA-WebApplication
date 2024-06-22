function delete_squad(button){
    const squadID = button.getAttribute('squad-id');
    const urlParams = new URLSearchParams(window.location.search);
    const username = urlParams.get('username');
    if(confirm('Are you sure you want to delete this squad?')){
        fetch('http://127.0.0.1:5000/delete_squad',{
        method: 'DELETE',
        headers:{
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            username:username,
            squadID: squadID,
        }),
        })
        .then(response=>{
            if(response.ok){
                alert('Squad Deleted');
                const listItem = button.closest('li');
                    listItem.remove();
            } else{
                alert('Task failed')
            }
        })
        .catch(error => console.error('error',error));
    }
}


function deletePlayer(button){
    const playerID = button.getAttribute('data-player-id');
    const squadID = button.getAttribute('squad-id');
    if(confirm('Are you sure you want to delete this player?')){
        fetch('http://127.0.0.1:5000/delete_player',{
        method: 'DELETE',
        headers:{
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            playerID: playerID,
            squadID: squadID,
        }),
        })
        .then(response=>{
            if(response.ok){
                alert('Player Deleted');
                const row = button.parentNode.parentNode;
                row.remove();
            } else{
                alert('Task failed')
            }
        })
        .catch(error => console.error('error',error));
    }
}

function createSquad(){
    const formation = document.getElementById('formation').value
    const urlParams = new URLSearchParams(window.location.search);
    const username = urlParams.get('username');
    console.log(username)

    fetch('http://127.0.0.1:5000/createsquad',{
        method: 'POST',
        headers:{
            'Content-Type':'application/json',
        },
        body: JSON.stringify({
            username: username,
           formation: formation,
        }),
        })
        .then(response => {
            if(response.ok){
                alert('Squad creation was successful!')
            }
            else{
                alert('Squad creation failed, Please try again.')
            }
        })
        .catch(error => console.log('error',error))
}


function searchPlayers(){
    const urlParams = new URLSearchParams(window.location.search);
    const username = urlParams.get('username');
    const playerName = document.getElementById('playerName').value;
    const position = document.getElementById('position').value;
    const club = document.getElementById('club').value;
    const league = document.getElementById('league').value;
    const nation = document.getElementById('nation').value;
    fetch(`http://127.0.0.1:5000/players?playerName=${playerName}&position=${position}&club=${club}&league=${league}&nation=${nation}`,{mode:'cors'},{
        method: 'GET',
        redirect:'follow'
        })
    .then(response => response.json())
    .then(data => {
        const table = document.getElementById('table');
        table.innerHTML='';
        data.forEach(result => {
            const row = document.createElement('tr');
            const pName = document.createElement('td');
            const pPosition = document.createElement('td');
            const pClub = document.createElement('td');
            const pLeague = document.createElement('td');
            const pNation = document.createElement('td');
            const addToSquad = document.createElement('button');
            addToSquad.textContent = "Add to Squad";
            addToSquad.classList.add('addToSquadButton');
            
            addToSquad.addEventListener('click',()=>{
                    const selectedSquadId = prompt('Enter Squad ID:'); // Use a more user-friendly method for squad selection

                    if (selectedSquadId !== null) {
                        addToSquadFunction(result, selectedSquadId);
                    }
                });
 
            pName.textContent = result.p_name;
            pPosition.textContent = result.p_position;
            pClub.textContent = result.p_club;
            pLeague.textContent = result.p_league;
            pNation.textContent = result.p_nation;
    
            row.appendChild(pName);
            row.appendChild(pPosition);
            row.appendChild(pClub);
            row.appendChild(pLeague);
            row.appendChild(pNation);
            row.appendChild(addToSquad)
            table.appendChild(row);
        });
    })
    .catch(error => console.log('error',error))
}
function addToSquadFunction(player,selectedSquadId){
    fetch(`http://127.0.0.1:5000/add_to_squad`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            squadId: selectedSquadId,
            playerId: player.p_id,
        }),
    })
        .then(response => {
            if (response.ok) {
                alert(`Player ${player.p_name} added to squad successfully!`);
            } else {
                alert(`Failed to add ${player.p_name} to squad. Please try again.`);
            }
        })
        .catch(error => console.log('error', error));
}

function login(){
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    fetch('http://127.0.0.1:5000/login',{
        method: 'POST',
        headers:{
            'Content-Type':'application/json',
        },
        body: JSON.stringify({
            username: username,
            password: password,
        }),
        })
        .then(response => {
            if (response.ok) {
                window.location.href = '/dashboard?username=' + encodeURIComponent(username);
            } else {
                alert('Login failed. Please try again.');
            }
        })
        .catch(error => console.log('error',error))
}

function register(){
    const newUsername = document.getElementById('newUsername').value;
    const newPassword = document.getElementById('newPassword').value;
    fetch(`http://127.0.0.1:5000/register`,{
        method: 'POST',
        headers:{
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            newUsername: newUsername,
            newPassword: newPassword,
        }),
    })
        .then(response => response.json())
        .then(response => {
            if (response.ok) {
                alert('Account created!')
            } else {
                alert('Login failed. Please try again.');
            }
        })
        .catch(error => console.log('error',error))
}

function squad_summary(button) {
    const squadID = button.getAttribute('squad-id');

    fetch(`/get_squad_summary/${squadID}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        alert(`
            Average Pace Diving: ${data.avg_pace_diving}
            Average Shooting Handling: ${data.avg_shooting_handling}
            Average Passing Kicking: ${data.avg_passing_kicking}
            Average Dribbling Reflexes: ${data.avg_dribbling_reflexes}
            Average Defense Speed: ${data.avg_defense_speed}
            Average Physical Positioning: ${data.avg_physical_positioning}
        `);
    })    
    .catch(error => console.error('Error fetching squad summary:', error));
}

