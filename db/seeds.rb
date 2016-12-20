user1 = User.create(name: "Enrique")
user2 = User.create(name: "Juan")
user3 = User.create(name: "Estela")
user4 = User.create(name: "Pedro")
user5 = User.create(name: "Javier")
user6 = User.create(name: "Daniel")
user7 = User.create(name: "Fabio")
user8 = User.create(name: "Abel")
user9 = User.create(name: "Max")
user10 = User.create(name: "Fede")


round1 = Round.create(winner: 1)
round2 = Round.create(winner: 3)
round3 = Round.create(winner: 6)
round4 = Round.create(winner: 7)
round5 = Round.create(winner: 10)



int1 = UserRound.create(user_id: user1.id, round_id: round1.id, score: 45)
int2 = UserRound.create(user_id: user2.id, round_id: round1.id, score: 60)

int3 = UserRound.create(user_id: user3.id, round_id: round2.id, score: 80)
int4 = UserRound.create(user_id: user4.id, round_id: round2.id, score: 30)

int5 = UserRound.create(user_id: user5.id, round_id: round3.id, score: 55)
int6 = UserRound.create(user_id: user6.id, round_id: round3.id, score: 60)

int7 = UserRound.create(user_id: user7.id, round_id: round4.id, score: 78)
int8 = UserRound.create(user_id: user8.id, round_id: round4.id, score: 23)

int9 = UserRound.create(user_id: user9.id, round_id: round5.id, score: 40)
int10 = UserRound.create(user_id: user10.id, round_id: round5.id, score: 76)