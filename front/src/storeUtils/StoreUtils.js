function getDateTime() {
    let daytime = new Date().toLocaleString()
    let daytime_tmp = new Date()
    let parsed_data = daytime.split(',')
    parsed_data[1] = parsed_data[1].substring(1)
    parsed_data[1] = parsed_data[1].slice(0, -3)
    return({date_str : parsed_data[0] + " " + parsed_data[1], date : daytime_tmp})

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

function getTimeDifferenciel()
{
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
    GetAllWorkingTimes,
    getTimeDifferenciel
}