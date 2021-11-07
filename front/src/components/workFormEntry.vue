<template>
  <v-container>
      <v-layout wrap>
        <v-flex sm12 md6 offset-md3>
          <v-card elevation="4" light tag="section">
            <v-card-title align-center>
                <h3 class="headline " > 
                  {{ platformDay }}
                </h3>
              
            </v-card-title>
            <v-divider></v-divider>

              <button id="1" class="day button" v-on:click="dayButtonClick(1)" name="Monday">M</button>
              <button id="2" class="day button" v-on:click="dayButtonClick(2)" name="Tuesday">T</button>
              <button id="3" class="day button" v-on:click="dayButtonClick(3)" name="Wednseday">W</button>
              <button id="4" class="day button" v-on:click="dayButtonClick(4)" name="Thursday">T</button>
              <button id="5" class="day button" v-on:click="dayButtonClick(5)" name="Friday">F</button>
              <button id="6" class="day button" v-on:click="dayButtonClick(6)" name="Saturday">S</button>
              <button id="7" class="day button" v-on:click="dayButtonClick(7)" name="Sunday">S</button> 

            <v-divider></v-divider>
            <v-card-actions :class="{ 'pa-3': $vuetify.breakpoint.smAndUp }">
              <v-btn color="info" flat @click="SignUp">
                RETURN
              </v-btn>
            </v-card-actions>
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
            <form @submit.prevent="submitTime">
              <v-text-field
                  outline
                  label=" Exemple: 9h30:18h30"
                  type="text" 
                  v-model="dateRawEntry"></v-text-field>
            </form>

            <div v-if="this.timeSubmited" >
            <section>
              <p> Have you eaten during this time ? </p>
                <input type="radio" id="one" value="Yes" name = "yes" v-model="lunchChoice">  Yes
                <br>
                <input type="radio" id="two" value="No" name = "no" v-model="lunchChoice">  No
                <br>
            </section>
            </div>

            <form v-if="lunchChoice == 'Yes'" @submit.prevent="lunchTime">
              <p> How long ? </p>
              <v-text-field
                  outline
                  label=" Exemple: 0h30"
                  type="text" 
                  v-model="lunchRawEntry"></v-text-field>
            </form>
            
            

            <v-divider></v-divider>
            <v-card-actions :class="{ 'pa-3': $vuetify.breakpoint.smAndUp }">
              <v-btn color="info" v-on:click=" clear()" flat @click="SignUp">
                RETURN
              </v-btn>
              <v-spacer></v-spacer>
              <v-btn color="info" v-on:click=" confirm(dateRawEntry)" :large="$vuetify.breakpoint.smAndUp">
                CONFIRM
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-flex>
      </v-layout>
      <p v-if="this.timeSubmitedConfirmed" > {{ this.confirmedMessage }}</p>

  </v-container>
  
</template>

<script>
export default {
  methods : {
    dayButtonClick(id){
      this.hourCount = 0
      this.activeDay = this.items[id-1].day
      this.confirmed = false
      this.timeSubmitedConfirmed = false
      this.timeSubmited = false

      if (this.dayAlreadyUp){
        this.setDaystoOff()
        this.setDaytoUp(id) 
      }
      else { 
        this.dayAlreadyUp = true
        this.showHour = true
        this.setDaytoUp(id)
      }

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
      this.dayAlreadyUp = false
      this.showHour = false
      this.dateRawEntry = '',
      this.lunchChoice = '',
      this.lunchRawEntry = '',
      this.timeSubmited = false,
      this.timeSubmitedConfirmed = false
      this.goodValues = true
    },
    timeAnalyse(dateRawEntry){
      console.log("DEBUG: timeAnalyse => ", dateRawEntry)
      // (9h12:17h23)
      this.time = dateRawEntry.split(':');
      this.startT = this.time[0] // 9h12
      this.endT = this.time[1]   // 17h23


      // Get all data
      this.startM = this.startT.split('h');
      this.hourStart = this.startM[0]       // 9 hour
      this.minuteStart = this.startM[1]     // 12 minute

      this.endM = this.endT.split('h');
      this.hourEnd = this.endM[0]           // 17 hour
      this.minuteEnd = this.endM[1]         // 23 minute

      // Check if entry is in the 23h00:6h00 format
      // Hour check
      if ((Number.parseInt(this.hourStart, 10) < 0 || Number.parseInt(this.hourEnd, 10) < 0 )
          || Number.parseInt(this.hourStart, 10) > 23 || Number.parseInt(this.hourEnd, 10) > 23){
        this.goodValues = false
        console.log("DEBUG: BAD VALUES")
      }
      if ((Number.parseInt(this.minuteStart, 10) < 0 || Number.parseInt(this.minuteEnd, 10) < 0 )
          || Number.parseInt(this.minuteStart, 10) > 59 || Number.parseInt(this.minuteEnd, 10) > 59){
        this.goodValues = false
        console.log("DEBUG: BAD VALUES")
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
          // Exemple: (9h30:9h10)
          else if (Number.parseInt(this.minuteEnd, 10) < Number.parseInt(this.minuteStart, 10)){
            // console.log("DEBUG: 9h30:9h10")
            console.log("DEBUG: BAD VALUES")
            this.confirmedMessage = "Bad data entry, please respect the 9h00:9h30 format"
            return 0
          }
          // Exemple: (9h10:9h10)
          else if (Number.parseInt(this.minuteEnd, 10) == Number.parseInt(this.minuteStart, 10)){
            // console.log("DEBUG: 23h00:6h00")
            this.minute = 0
            this.hour = 0
          }
          console.log("DEBUG: 9h00:9h30")
        }
        this.confirmedMessage = "Employee " + this.employeName + " worked "+ this.hour + "h" + this.minute + " on " + this.activeDay
        // console.log("worked:" + this.hour + "h" + this.minute)
      }
      else{
        this.confirmedMessage = "Bad data entry, please respect the 9h00:9h30 format"
      }

      // RETURN STRING TO INT ???
      // TO DO
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
      platformDay: 'Choose a day',
      platformHour: 'Write down your entry and leaving hour',
      employeName : 'XXX',
      activeDay : '',
      email: null,
      username: null,
      showHour : false,
      dayAlreadyUp : false,
      confirmed : false,
      timeSubmited : false,
      timeSubmitedConfirmed : false,
      notActiveDayColor : "#04AA6D",
      activeDayColor : "#2196f3",
      hourCount : 0,
      dateRawEntry : '',
      lunchChoice : '',

      hourWorked : '',
      minuteWorked : '',

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

      day : String,

      items: [
        { day: 'Monday' , id:1},
        { day: 'Tuesday' , id:2},
        { day: 'Wednesday' , id:3},
        { day: 'Thursday' , id:4},
        { day: 'Friday' , id:5},
        { day: 'Saturday' , id:6},
        { day: 'Sunday'  , id:7},
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
}

</style>