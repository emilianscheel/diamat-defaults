const bcr = require('bcrypt')




async function start() {
    const password = "2resu"

    const hashedPassword = await bcr.hash(password, 10);

    console.log(hashedPassword)
}


start()

