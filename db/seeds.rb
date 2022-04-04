# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Theme.delete_all
Theme.reset_primary_key
Theme.create([

               {name: "-----"},      # 1 Нет темы
               {name: "Какое из произведений художника О.Ренуара наилучшим образом характеризует его творчество?"},      # 2
               {name: "Какое из произведений художника П.Пикассо наилучшим образом характеризует его творчество?"},      # 3
               {name: "Какое из произведений художника А.Матисса наилучшим образом характеризует его творчество?"},      # 4
             ])


Image.delete_all
Image.reset_primary_key
Image.create([

               {name: 'P.-A. Renoir, Бал в Мулен де ла Галетт', file: 'Renoir Бал в Мулен де ла Галлет.jpg', theme_id: 2},
               {name: 'P.-A. Renoir, Букет', file: 'Renoir букет.jpg', theme_id: 2},
               {name: 'P. Picasso, Фабрика', file: 'Picasso Fabrique.jpg', theme_id: 3},
               {name: 'H. Matiss, Балерина', file: 'Matiss Балерина.jpg', theme_id: 4},
             ])
User.delete_all
User.reset_primary_key
User.create([
              {name: 'test', email: 'test@test.tt'}
            ])
