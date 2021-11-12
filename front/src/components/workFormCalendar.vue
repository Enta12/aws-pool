<template>
  <v-container>
      <v-layout wrap>
        <v-flex sm12 md6 offset-md3>
          <v-card elevation="4" light tag="section">
            <v-card-title align-center>
                <h3 class="center" align-center > 
                  {{ platformDay }} {{ ""+ this.val }}
                </h3>
              
            </v-card-title>

            <v-divider></v-divider>
              
              <v-date-picker full-width v-model="pickedValue" @change="dayButtonClick(pickedValue)">
              </v-date-picker>

            <v-divider></v-divider>
          </v-card>
        </v-flex>
        
      </v-layout>
      <v-layout v-if="this.showHour" wrap>
        <v-flex sm12 md6 offset-md3>
          <v-card elevation="4" light tag="section">
            <v-card-title>
              <v-layout align-center justify-space-between>
                <h3 class="headline" > 
                  {{ platformHour }}
                </h3>
              </v-layout>
            </v-card-title>
            <v-divider></v-divider>
            <form @submit.prevent="submitTime" >
              <v-text-field
                  outline
                  label=" Exemple: 09h30:18h30"
                  type="text" 
                  v-model="dateRawEntry"
                  @keydown.enter="confirm(dateRawEntry)"></v-text-field>
            </form>
            
            <v-card-actions :class="{ 'pa-3': $vuetify.breakpoint.smAndUp }">
              <v-btn color="info" v-on:click=" clear()">
                RETURN
              </v-btn>
              <v-spacer></v-spacer>
              <v-btn color="info" v-on:click="confirm(dateRawEntry)" :large="$vuetify.breakpoint.smAndUp">
                CONFIRM
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
      </v-layout>

      <v-layout v-if="this.timeSubmitedConfirmed" wrap>
        <v-flex sm12 md6 offset-md3>
          <v-card elevation="4" >
            <v-divider></v-divider>
            <div class="center">
               <h3> 
                {{ this.confirmedMessage }}
              </h3>
            </div>
            <v-divider></v-divider>
          </v-card>
        </v-flex>
      </v-layout>  

       
  </v-container>
  
</template>

<script>
export default {
  
  methods : {
    dayButtonClick(date){
      this.confirmed = false
      this.timeSubmitedConfirmed = false
      this.timeSubmited = false
      this.showHour = true
      this.dateAnalyse(date)
    },
    getEmployeeName(rawEmployeeName){
      this.employeeName = rawEmployeeName
    },

    confirm(dateRawEntry){
      // Clear the interface
      this.clear()
      this.timeSubmitedConfirmed = true
      this.timeAnalyse(dateRawEntry)

      return 0
    },
    clear(){
      this.setDaystoOff()
      this.showHour = false
      this.dateRawEntry = ''
      this.timeSubmited = false
      this.timeSubmitedConfirmed = false
      this.goodValues = true
      this.totalTimeWorkedDay = 0
    },
    dateAnalyse(dateRawEntry){
      // 2021-11-20 dateRawEntry
      const dateSplit = dateRawEntry.split('-')  
      this.dateCleanEntry = dateRawEntry

      // Get month from month number
      this.monthEntry = this.monthItems[dateSplit[1]-1].month

      this.dateToString = dateSplit[2] + " " + this.monthEntry + " " + dateSplit[0]
      console.log(this.dateToString)
    },

    errorMessage(errorType){
      this.showHour = true
      console.log("DEBUG ERROR MESSAGE" + errorType)
      if (errorType == 'bad format') 
        this.confirmedMessage = "Bad data entry, please respect the 09h00:09h30 format"

      if (errorType == 'bad hour entry') 
        this.confirmedMessage = "Bad data entry, acceptable hours: 00h -> 23h"

      if (errorType == 'bad minute entry') 
        this.confirmedMessage = "Bad data entry, acceptable minutes: 00 -> 59"

      if (errorType == 'work time > 12 hour') 
        this.confirmedMessage = "Bad data entry, cannot work more than 12 hours"

      if (errorType == 'bad data entry') 
        this.confirmedMessage = "Bad data entry..."
    },
    timeAnalyse(timeRawEntry){
      // Check if the entry is correct
      if (timeRawEntry[2] != "h" || timeRawEntry[5] != ":" || timeRawEntry[8] != "h" ) return this.errorMessage('bad format')

      console.log("DEBUG: timeAnalyse => ", timeRawEntry)
      // (9h12:17h23)
      this.time = timeRawEntry.split(':');
      this.startT = this.time[0] // 9h12
      this.endT = this.time[1]   // 17h23


      // Get all data
      this.startM = this.startT.split('h');
      this.hourStart = this.startM[0]       // 9 hour
      this.minuteStart = this.startM[1]     // 12 minute

      this.endM = this.endT.split('h');
      this.hourEnd = this.endM[0]           // 17 hour
      this.minuteEnd = this.endM[1]         // 23 minute

      // Check if the entry is coherent 23h00:6h00 format
      // Hour check
      if ((Number.parseInt(this.hourStart, 10) < 0 || Number.parseInt(this.hourEnd, 10) < 0 )
          || Number.parseInt(this.hourStart, 10) > 23 || Number.parseInt(this.hourEnd, 10) > 23){
        this.goodValues = false
        console.log("DEBUG: BAD VALUES")
        return this.errorMessage('bad hour entry')
      }
      // Minutes check
      if ((Number.parseInt(this.minuteStart, 10) < 0 || Number.parseInt(this.minuteEnd, 10) < 0 )
          || Number.parseInt(this.minuteStart, 10) > 59 || Number.parseInt(this.minuteEnd, 10) > 59){
        this.goodValues = false
        console.log("DEBUG: BAD VALUES")
        return this.errorMessage('bad minute entry')
      }

    
      if (this.goodValues){
        // if hourStart < hourEnd (9h12:17h23)
        if (Number.parseInt(this.hourStart, 10) < Number.parseInt(this.hourEnd, 10)){
          //console.log("DEBUG: hourstart < hour end ", this.hourStart, " " ,this.hourEnd, "=> ", this.hourStart-this.hourEnd)
          // Exemple: (9h12:17h23)
          if (Number.parseInt(this.minuteEnd, 10) > Number.parseInt(this.minuteStart, 10)){
            this.minute = this.minuteEnd - this.minuteStart
            this.hour = this.hourEnd - this.hourStart
          }
          // Exemple: (9h59:17h03)
          else if (Number.parseInt(this.minuteEnd, 10) < Number.parseInt(this.minuteStart, 10)){
            this.minute = 60 - (this.minuteStart - this.minuteEnd)
            this.hour = this.hourEnd - this.hourStart - 1
          }
          // Exemple: (9h30:17h30)
          else if (Number.parseInt(this.minuteEnd, 10) == Number.parseInt(this.minuteStart, 10)){
            this.minute = 0
            this.hour = this.hourEnd - this.hourStart
          }
        }


        // if hourStart > hourEnd (23h00:6h00)
        else if (Number.parseInt(this.hourStart, 10) > Number.parseInt(this.hourEnd, 10)){
          // Exemple: (23h00:6h30)
          if (Number.parseInt(this.minuteEnd, 10) > Number.parseInt(this.minuteStart, 10)){
            // console.log("DEBUG: 23h00:6h30")
            this.minute = this.minuteEnd - this.minuteStart
            this.hour = 24 - (this.hourStart - this.hourEnd)
          }
          // Exemple: (23h59:6h03)
          else if (Number.parseInt(this.minuteEnd, 10) < Number.parseInt(this.minuteStart, 10)){
            // console.log("DEBUG: 23h59:6h03")
            this.minute = 60 - (this.minuteStart - this.minuteEnd)
            this.hour = 24 - (this.hourStart - this.hourEnd) - 1
          }
          // Exemple: (23h00:6h00)
          else if (Number.parseInt(this.minuteEnd, 10) == Number.parseInt(this.minuteStart, 10)){
            // console.log("DEBUG: 23h00:6h00")
            this.minute = 0
            this.hour = 24 - (this.hourStart - this.hourEnd)
          }
        }

        // if hourStart == hourEnd (9h00:9h30)
        else if (Number.parseInt(this.hourStart, 10) == Number.parseInt(this.hourEnd, 10)){
          // Exemple: (9h00:9h30)
          if (Number.parseInt(this.minuteEnd, 10) > Number.parseInt(this.minuteStart, 10)){
            // console.log("DEBUG: 9h00:9h30")
            this.minute = this.minuteEnd - this.minuteStart
            this.hour = 0
          }
          // Exemple: (9h10:9h10)
          else if (Number.parseInt(this.minuteEnd, 10) == Number.parseInt(this.minuteStart, 10)){
            return this.errorMessage('bad data entry')
          }
          // Exemple: (9h30:9h10)
          else if (Number.parseInt(this.minuteEnd, 10) < Number.parseInt(this.minuteStart, 10)){
            return this.errorMessage('work time > 12 hour')
          }
        }
        if(this.hour >= 10) 
          if (this.minute >= 10) 
            this.confirmedMessage = "Employee " + this.employeeName + " worked "+ this.hour + "h" + this.minute + " on the " + this.dateToString
          else
            this.confirmedMessage = "Employee " + this.employeeName + " worked "+ this.hour + "h0" + this.minute + " on the " + this.dateToString

        else if(this.hour < 10) 
          if (this.minute >= 10) 
            this.confirmedMessage = "Employee " + this.employeeName + " worked 0"+ this.hour + "h" + this.minute + " on the " + this.dateToString
          else
            this.confirmedMessage = "Employee " + this.employeeName + " worked 0"+ this.hour + "h0" + this.minute + " on the " + this.dateToString
            
        
        
        
        this.totalTimeWorkedDay = this.hour * 60 + this.minute
        if(this.totalTimeWorkedDay > 720) return this.errorMessage('work time > 12 hour')
        
        const returnValues = [this.hour, this.minute, this.startT, this.endT, this.employeeName, this.dateCleanEntry, this.dateToString, this.totalTimeWorkedDay]
        console.log(returnValues)
        return returnValues
      }
      else{
        this.confirmedMessage = "Bad data entry, please respect the 09h00:09h30 format"
      }
    },

    setDaystoOff(){
      var days = document.getElementsByClassName("day button");
      for(var dayID = 1; dayID <= days.length; dayID++) {
        let element = document.getElementById(dayID)
        element.style.backgroundColor = this.notActiveDayColor 
      }
      for (const element of document.getElementsByClassName("hourCheck")){
        element.checked = false;
      }
    },
    submitTime(){
      this.timeSubmited = true
    },  

    setDaytoUp(id){
        let element = document.getElementById(id)
        element.style.backgroundColor = this.activeDayColor 
    },  


    setHourToUncheck(){
      for (const element of document.getElementsByClassName("hourCheck")){
        element.checked = false;
      }
    }
  },


  data () {
    return {
      darkTheme: true,
      platformDay: 'Choose a day to add a working time',
      platformHour: 'Write down your entry and leaving hour',
      employeeName : 'XXX',
      activeDay : '',
      email: null,
      username: null,
      showHour : false,
      confirmed : false,
      timeSubmited : false,
      timeSubmitedConfirmed : false,
      notActiveDayColor : "#04AA6D",
      activeDayColor : "#2196f3",
      dateRawEntry : '',
      timeRawEntry : '',
      lunchChoice : '',
      val : '',
      dateCleanEntry : [],
      
      pickedValue : '',
      monthEntry : '',

      totalTimeWorkedDay : 0,

      time : '',
      startT : '',
      startM : '',
      hourStart : '',
      minuteStart : '',
      endM : '',
      hourEnd : '',
      minuteEnd : '',
      hour : '',
      minute : '',
      goodValues : true,

      confirmedMessage : '',
      dateToString : '',

      day : String,
      returnData: [
        { hour: 0 , id:1},
        { minute: 0 , id:2},
        { employeeName: '' , id:3},
        { dateEntry: '' , id:4},
        { dateToString: '' , id:5},
        { totalTimeWorkedDay: '0' , id:6},
      ],
      
      items: [
        { day: 'Monday' , id:1},
        { day: 'Tuesday' , id:2},
        { day: 'Wednesday' , id:3},
        { day: 'Thursday' , id:4},
        { day: 'Friday' , id:5},
        { day: 'Saturday' , id:6},
        { day: 'Sunday'  , id:7},
      ],
      monthItems: [
        { month: 'January' , id:1},
        { month: 'February' , id:2},
        { month: 'March' , id:3},
        { month: 'April' , id:4},
        { month: 'May' , id:5},
        { month: 'June' , id:6},
        { month: 'July' , id:7},
        { month: 'August' , id:8},
        { month: 'September' , id:9},
        { month: 'October' , id:10},
        { month: 'November' , id:11},
        { month: 'December' , id:12},
      ]
    }
  },
}
</script>

<style scoped>

.button {
  background-color: #04AA6D; /* Green */
  border: none;
  color: white;
  padding: 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 50%;
}
.center{
  text-align: center;
  font-weight: normal;
}

</style>