user = User.create(email: "andrey.volcov@gmail.com", password: "11111111")

currency = Currency.create(name: "Молдавский лей", abbr_name: "MDL", exchange_rate: 1, default_currency: true)

Account.create([{name: 'AAA', funds: 100, user_id: user.id, active: true, currency_id: currency.id}, 
                {name: 'Test Acc', funds: 200, user_id: user.id, active: true, currency_id: currency.id}])

Category.create([{name: 'Траты 1', user_id: user.id},
                 {name: 'Траты 2', user_id: user.id}])
