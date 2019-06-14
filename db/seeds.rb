drew = User.create(name: "Drew", email: "drew@drew.com", password: "password")
sherry = User.create(name: "Sherry", email: "sherry@sherry.com", password: "password")

CrossfitWorkout.create(workout_name: "Cindy", content: "Complete as many rounds in 20 minutes as you can of:5 Pull-ups, 10 Push-ups, 15 Squats", user_id: drew.id)

drew.crossfit_workouts.create(workout_name: "Kelly", content: "Five rounds for time of: Run 400 meters, 30 Box jump, 24 inch box,30 Wall ball shots, 20 pound ball")

sherrys_entry = sherry.crossfit_workouts.build(workout_name: "Nate", content: "AMRAP: 2 Muscle-ups, 4 Handstand Push-ups, 8 2-Pood Kettlebell swings")
sherrys_entry.save
