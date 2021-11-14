import store from "../store/Store";

function getDateTime() {
    let i = 0
    let save = 0
    let date = [" janvier", "fevrier", "mars", "avril", "mai", "juin", "juillet", "aout", "septembre", "octobre", "novembre", "decembre"]
    let today = new Date()

    for (let tmp of date) {
        ++i;
        if (tmp === today.toLocaleString('it-IT', { month: 'long' }))
        {
            save = i
        }
    }
    let daytime = new Date()
    let daytime_tmp = new Date()
    let month = addZero(save.toString())
    let day = addZero(today.toString().split(" ")[2])
    let hour = addZero(daytime.getHours().toString())
    let minute = addZero(daytime.getMinutes().toString())
    let second = addZero(daytime.getSeconds().toString())

    return({date_str : daytime.getFullYear() + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second, date : daytime_tmp})
}

function addZero(time) {
    if (time.length <= 1) {
        time = "0" + time
    }
    return time
}

async function getAllWorkingTimeForTheDay(today) {
    let tmp
    console.log(today)
    let workingtimesOfToday = []
    let data =  await GetAllWorkingTimes(store.state.user.id)
    data.map(x =>
    {
        tmp = x.start.split('T')
        if (Date.parse(tmp[0]) ===  Date.parse(today))
            workingtimesOfToday.push(tmp[0])
    })
    return workingtimesOfToday
}

async function GetAllWorkingTimes(userid)
{
    let response = await fetch("http://ligne7.pepintrie.fr:4000/api/workingtimes/" + userid, { method: 'GET',}).then((res) => {
        return res.json()
    }).catch((err) => {
        console.log(err)
    })
    return response.data
}

export {
    getDateTime,
    getAllWorkingTimeForTheDay,
    GetAllWorkingTimes
}