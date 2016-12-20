$(document).ready(function() {
  counter = 0; 

// tomar control del formulario
  $( "#log" ).on("submit", function( event ) {
      event.preventDefault();
      userInput = $(this).serialize(); 
      $.post("/play", userInput, function(data) {
        $("#game").html(data);
      });

  }); 
 
  //Comienza el movimiento de los jugaodres cuando le da click al star button
  $("#start_btn").on("click", function(){
        //Tomar los valores  que se ingresaron en la forma 
        //Se genera una variable que toma el elemento input de la forma con el nombre player1
        player1 = $("input[name=player1]").val();
        player2 = $("input[name=player2]").val();
        //Declara la variable global para parar a cada jugador  
        stop1 = false;
        stop2 = false;
        //Variables que obtienen el index de en donde se detuvo cada juagador
        diference1 = 200;
        diference2 = 200;
        //llama al metodo move y stopcoin para cada uno de los jugadores
        move("player1");
        $(document).on('keydown', stopCoin);
        move("player2");
        $(document).on('keydown', stopCoin);
  });
});
//hacer una llamada al metodo para volver a jugar 
var reset = function(player) { 
  $("#player1").find(".active").first().removeClass("active");
  $("#player1").find(".td_game").first().addClass("active"); 
  $("#player2").find(".active").first().removeClass("active");
  $("#player2").find(".td_game").first().addClass("active"); 
}
      
 

// metodo que activa y desactiva las celdas
var move = function(player) { 
  // Sirve para seleccionar la celda activa de cada jugador
  var currentCell = $("#" + player + "> .active");
  var currentPlayer = player
  var nextCell = currentCell.next();
  var index = currentCell.attr("id");
  //Modifica la clase activa para cada una de las celdas
  currentCell.removeClass("active");
  nextCell.addClass("active"); 
  //Establece la velocidad del movimiento con el que se activan y se desactivan las teclas
  var timer = setTimeout(function(){
    move(player);
  }, 10);  
  //Para el movimiento de la barra  y obtiene la celda en la que se detuvo
  if (stop1 == true && currentPlayer == "player1" || index == 100){
    clearTimeout(timer);
    determineWinner(index, currentPlayer);
  }else if(stop2 == true && currentPlayer == "player2" || index == 100){
    clearTimeout(timer);
    determineWinner(index, currentPlayer);
  }
}

//Establece la tecla que le corresponde a cada jugador para detener la barra
var stopCoin = function(event) { 
  var x = event.keyCode;
  if (event.keyCode == 81) {
      stop1 = true;
  }
  if (event.keyCode == 80) {
     stop2 = true;
  }
}

//Evalua que jugador es el ganador 
var determineWinner = function(currentIndex, player) { 
  var winner = "";
  counter += 1
  if (player == "player1" && currentIndex < 100 ) {
     diference1 = 100 - currentIndex; 
  }else if (player == "player2" && currentIndex < 100 ) {
     diference2 = 100 - currentIndex; 
  }else {
    if (player == "player1"){
       diference1 = currentIndex * 2;
    }else if (player == "player2") { 
       diference2 = currentIndex * 2;
    }
  }
  // Genera los mensajes de ganador para el usuario y resetea el juego
  if (diference1 < diference2){
    var message = "Ganador: ¡Jugador 1! " 
    winner = "player1"
  }else if(diference2 < diference1){
     message = "Ganador: ¡Jugador 2! " 
    winner = "player2"
  }else if(diference1 == diference2 && diference1 != 200 && diference2 != 200){
    var message = "Empate, juega de nuevo para tener un ganador"
    winner = "none" 
  }else if(diference1 == 200 && diference2 == 200){
    var message = "Ambos jugadores perdieron" 
    winner = "none"
  }
  //Manda a la vista el mensaje 
  $("#display").html(message);
  //Metodo que manda una hash con la informacion de la partida al metodo post round 
  if (counter > 1) {
    $.post("/round", {"player1": player1, "player2": player2, "score1": diference1, "score2": diference2,"round_winner": winner }, function(data) {
      reset().delay(900000);
    });
    $.get("/round", {"player1": player1, "player2": player2, "score1": diference1, "score2": diference2,"round_winner": winner }, function(data) {
      $("#link").html(data);
    });
}
}











