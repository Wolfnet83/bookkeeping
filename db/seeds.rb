user = User.create(email: "andrey.volcov@gmail.com", password: "11111111")
Account.create([{name: 'Наличные', funds: 100, user_id: user.id},
                {name: 'Test Acc', funds: 200, user_id: user.id}])
Category.create([{name: 'Траты 1', user_id: user.id},
                 {name: 'Траты 2', user_id: user.id}])
