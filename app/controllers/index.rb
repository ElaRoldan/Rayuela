get '/' do
  erb :index
end

get '/restart/:player1/:player2' do 
  @player1 = params[:player1]
  @player2 = params[:player2]
  erb :new_game
end  

#Encuentra los jugadores de la ronda y su resultado para mandarlos a la vista result
get '/result/:id' do
  @round = Round.find(params[:id])
  round_winner = @round.winner
  winner = User.find_by(id: round_winner)
  users = UserRound.where(round_id: @round)
  ids = []
  scores = []
  names = []
  users.each do |user|
    ids << user.user_id
    user.score == 200 ? points = 0 : points = 100 - user.score
    scores << points  
  end   
  ids.each do |id|
    names << User.find(id).name
  end 
  if scores.uniq.count == 1
    @round_result = [names[0],scores[0],names[1],scores[1]]
  else
    @round_result = [names[0],scores[0],names[1],scores[1], winner.name]
  end  
  erb :result
end

#Manda a la vista parcial la informacion para generar el link 
get '/round' do 
  round = Round.last.id
  @link = "#{round}"
  erb :_link, layout: false  if request.xhr?
end  

post '/play'  do 
  erb :game
end 

#Crea todos los registros de la ronda en la base de datos
post '/round' do 
  #Toma la informacion del usuario
  player1 = params[:player1]
  player2 = params[:player2]
  score1 = params[:score1]
  score2 = params[:score2]
  round_winner = params[:round_winner]
  #Crea y valida los ususarios en la base
  pl = User.find_by(name: player1) 
  pa = User.find_by(name: player2)
  p1 = validate(pl, player1)
  p2 = validate(pa, player2)
  #Genera las rondas con el ganador
  if round_winner == "player2"
    r1 = Round.create(winner: p2.id)
  elsif round_winner == "player1"
    r1 = Round.create(winner: p1.id)
  elsif round_winner == "none"
    r1 = Round.create
  end
  #Crea el registro en la tabla intermedia
  UserRound.create(user_id: p1.id, round_id: r1.id, score: score1)
  UserRound.create(user_id: p2.id, round_id: r1.id, score: score2)  
end 

#Valida a los usuarios en la base de datos
def validate(player, new_player)
  if player
    return player_search = User.find_by(name: player.name) 
  else 
    return player_search = User.create(name: new_player)
  end 
end

    
 

