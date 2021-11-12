function getDateTime() {
    let daytime = new Date()
    let daytime_tmp = new Date()
    let month = addZero(daytime.getMonth().toString())
    let day = addZero(daytime.getDay().toString())
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

async function getAllWorkingTimeForTheDay() {
    let tmp
    let today = getDateTime().date_str.split(" ")[0]
    let workingtimesOfToday = []
    let data =  await GetAllWorkingTimes(this.$store.state.user.id)
    data.map(x =>
    {
        tmp = x.start.split('T')
        tmp[0] = tmp[0].replaceAll('-', '/')
        if (Date.parse(tmp[0]) ===  Date.parse(today))
            workingtimesOfToday.push(tmp[0])
    })
    console.log(workingtimesOfToday)
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