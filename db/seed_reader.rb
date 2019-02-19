

vault_guy = User.create(username: "Vault Dweller", street: '13', city: "Vault", state: "Vault-Tec", zip_code: "47010", email: 'dweller@vt.com', password: '1234')
chosen_one = User.create(username: "Chosen One", street: '1', city: "Arroyo", state: "California", zip_code: "52801", email: 'chosen1@ca.com', password: '1234')
lone_wanderer = User.create(username: "Lone Wanderer", street: '101', city: "Vault", state: "Vault-tec", zip_code: "43231", email: 'solonely@vt.com', password: '1234', role:1)
courier = User.create(username: "Courier 6", street: '1450', city: "Cemetery", state: "Goodsprings", zip_code: "56721", email: 'mailman6@ups.com', password: '1234', role: 1)
moira = User.create(username: "Moira Brown", street: 'Craterside Supply', city: "Megaton", state: "DC", zip_code: "23143", email: 'anything@bomb.com', password: '1234', role: 1)
User.create(username: "Sole Survivor", street: '1082', city: "Sanctuary Hills", state: "Massachusetts", zip_code: "94518", email: 'superchill@bo.com', password: '1234', role: 2)

dandy =Item.create(name: "Dandy Boy Apples", description: "A little stale but still full of sugar!", quantity: 15, price: 15.25, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/0/05/Fo4_Dandy_Boy_Apples.png/revision/latest?cb=20160427211903', user_id: courier.id)
Item.create(name: "Fancy Lad Snack Cakes", description: "Tastes better than a bullet, still puts a hole in your teeth like one.", quantity: 22, price: 4.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/5/57/Fallout4_Fancy_lads_snack_cakes.png/revision/latest?cb=20160118215034', user_id: courier.id)
dcw = Item.create(name: "Deathclaw Wellingham", description: "Don't ask how we got the meat.", quantity: 6, price: 32.50, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/5/5a/Deathclaw_Wellingham.png/revision/latest?cb=20170317165651', user_id: courier.id)
Item.create(name: "Euclid's C-Finder", description: "Adds a whole new meaning to danger close", quantity: 1, price: 743.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/a/a9/Euclid%27s_C-Findercropped1.png/revision/latest?cb=20110208215156', user_id: courier.id)
flare_gun = Item.create(name: "Flare Gun", description: "Aim up pull trigger, pretty simple right?", quantity: 3, price: 743.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/a/a1/Flare_gun.png/revision/latest?cb=20110921025012', user_id: courier.id)
flares = Item.create(name: "Flare", description: "Makes the gun go boom, kinda.", quantity: 400, price: 1.50, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/6/62/FNVLR_flare.png/revision/latest?cb=20131231190751', user_id: courier.id)

Item.create(name: "Firelance", description: "I swear, it came from space!", quantity: 1, price: 1050.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/0/00/F3Firelance.png/revision/latest/scale-to-width-down/242?cb=20110207053519', user_id: lone_wanderer.id)
Item.create(name: "Alien Power Cell", description: "Don't bite, your face will melt", quantity: 362, price: 12.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/c/c4/Alien_Power_Cell.png/revision/latest/scale-to-width-down/242?cb=20110405004345', user_id: lone_wanderer.id)
bobble = Item.create(name: "Bobblehead - Barter", description: "No, you will not get a better deal after you buy this.", quantity: 2, price: 26.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/c/ca/Bobblehead_Barter.png/revision/latest/scale-to-width-down/137?cb=20110307013617', user_id: lone_wanderer.id)
pork = Item.create(name: "Pork n' Beans", description: "Might be a century old but at least it's edible.", quantity: 21, price: 9.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/4/40/FO3_Pork_n%27_Beans.png/revision/latest?cb=20130531211348', user_id: lone_wanderer.id)

Item.create(name: "Wasteland Survival Guide", description: "It'll save your life!", quantity: 13, price: 5.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/3/3b/The_Wasteland_Survival_Guide.png/revision/latest?cb=20121209004421', user_id: moira.id)
nuka = Item.create(name: "Nuka-Cola", description: "Mmm, taste those rads", quantity: 42, price: 20.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/0/04/FO3_Nuka-Cola.png/revision/latest/scale-to-width-down/109?cb=20160114003530', user_id: moira.id)
stimpak = Item.create(name: "Stimpak", description: "It's like magic!", quantity: 79, price: 25.00, thumbnail: 'https://vignette.wikia.nocookie.net/fallout/images/8/86/FO3_stimpak.png/revision/latest/scale-to-width-down/242?cb=20110216211730', user_id: moira.id)

order_1 = Order.create(user_id: vault_guy.id)
order_2 = Order.create(user_id: vault_guy.id)
order_3 = Order.create(user_id: vault_guy.id)

order_4 = Order.create(user_id: chosen_one.id)
order_5 = Order.create(user_id: chosen_one.id)

OrderItem.create(order_id: order_1.id, item_id: dandy.id, quantity: 3, current_price: 45.75)
OrderItem.create(order_id: order_1.id, item_id: dcw.id, quantity: 1, current_price: 32.50)

OrderItem.create(order_id: order_2.id, item_id: flare_gun.id, quantity: 1, current_price: 743.00)
OrderItem.create(order_id: order_2.id, item_id: flares.id, quantity: 20, current_price: 30.00)
OrderItem.create(order_id: order_2.id, item_id: stimpak.id, quantity: 3, current_price: 75.00)

OrderItem.create(order_id: order_3.id, item_id: stimpak.id, quantity: 5, current_price: 125.00)
OrderItem.create(order_id: order_3.id, item_id: nuka.id, quantity: 2, current_price: 40.00)

OrderItem.create(order_id: order_4.id, item_id: pork.id, quantity: 4, current_price: 36.00)
OrderItem.create(order_id: order_4.id, item_id: bobble.id, quantity: 1, current_price: 26.00)

OrderItem.create(order_id: order_5.id, item_id: nuka.id, quantity: 1, current_price: 20.00)
OrderItem.create(order_id: order_5.id, item_id: bobble.id, quantity: 1, current_price: 26.00)
OrderItem.create(order_id: order_5.id, item_id: dcw.id, quantity: 1, current_price: 32.50)
OrderItem.create(order_id: order_5.id, item_id: stimpak.id, quantity: 10, current_price: 250.00)
