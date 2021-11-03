function getDateTime() {
    let daytime = new Date().toLocaleString()
    let parsed_data = daytime.split(',')
    parsed_data[1] = parsed_data[1].substring(1)
    parsed_data[1] = parsed_data[1].slice(0, -3)
    return(parsed_data[0] + " " + parsed_data[1])

}

export {
    getDateTime
}