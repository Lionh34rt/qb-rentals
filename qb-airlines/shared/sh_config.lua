Config = {}

Config.Planes = {
    [1] = {
        model = "mammatus",
        label = "Jobult Mammatus",
        capacity = "3 + 1 Pilot",
        url = "https://i.gyazo.com/34059a172afc68aa04712791f6001903.jpg",
        price = "350",
    },
    [2] = {
        model = "frogger",
        label = "Maibatsu Frogger",
        capacity = "3 + 1 Pilot",
        url = "https://i.gyazo.com/128c9c2ab0a9a840546247534050bf10.jpg",
        price = "550",
    },
    [3] = {
        model = "velum",
        label = "Jobuilt Velum",
        capacity = "4 + 1 Pilot",
        url = "https://i.gyazo.com/169c8bd4288e6cd50c09f240f7ad76f7.jpg",
        price = "500",
    },
    [4] = {
        model = "nimbus",
        label = "Buckingham Nimbus",
        capacity = "7 + 1 Pilot",
        url = "https://i.gyazo.com/3286f22f18806866d6de85b38b1436f1.jpg",
        price = "2000",
    }
}

Config.Airports = {
    ["LSIA"] = vector4(-1274.97, -3386.68, 13.94, 328.33),
    ["SS"] = vector4(1696.53, 3250.61, 40.93, 101.26)
}

Config.Items = {
    label = "Airlines",
    slots = 1,
    items = {
        [1] = {
            name = "parachute",
            price = 200,
            amount = 10,
            info = {},
            type = "item",
            slot = 1,
        }
    }
}
