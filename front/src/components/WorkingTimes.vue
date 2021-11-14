<template>
  <div class="working-times">
    <v-list class="listCard">
      <div>
        <v-toolbar flat>
          <v-btn outlined class="mr-4" color="grey darken-2" @click="setToday">
            Today
          </v-btn>
          <v-btn fab text small color="grey darken-2" @click="prev">
            <v-icon small> mdi-chevron-left </v-icon>
          </v-btn>
          <v-btn fab text small color="grey darken-2" @click="next">
            <v-icon small> mdi-chevron-right </v-icon>
          </v-btn>
          <v-toolbar-title v-if="$refs.calendar">
            {{ $refs.calendar.title }}
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-menu bottom right>
            <template v-slot:activator="{ on, attrs }">
              <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
                <span>{{ typeToLabel[type] }}</span>
                <v-icon right> mdi-menu-down </v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item @click="type = 'day'">
                <v-list-item-title>Day</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'week'">
                <v-list-item-title>Week</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = 'month'">
                <v-list-item-title>Month</v-list-item-title>
              </v-list-item>
              <v-list-item @click="type = '4day'">
                <v-list-item-title>4 days</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-toolbar>
        <template>
          <v-calendar
            @click:more="viewDay"
            @click:date="viewDay"
            ref="calendar"
            v-model="focus"
            color="primary"
            :events="dataWorks"
            :event-color="getEventColor"
            :type="type"
            @click:event="showEvent"
            @change="updateRange"
          >
          </v-calendar>
        </template>

        <v-menu
          v-model="selectedOpen"
          :close-on-content-click="false"
          :activator="selectedElement"
          offset-x
        >
          <v-card color="grey lighten-4" min-width="350px" flat>
            <v-toolbar :color="selectedEvent.color" dark>
              <v-btn icon @click="showModal = !showModal">
                <v-icon>mdi-pencil</v-icon>
              </v-btn>

              <v-toolbar-title
                v-html="selectedEvent.id_works"
              ></v-toolbar-title>
              <v-spacer></v-spacer>
              <v-btn icon>
                <v-icon>mdi-close</v-icon>
              </v-btn>
            </v-toolbar>
            <div class="d-flex justify-center">
              <v-card-text class="justify-center align-center">
                <h3>Id : {{ selectedEvent.id }}</h3>
              </v-card-text>
              <v-card-text class="justify-center align-center">
                <h3>start : {{ selectedEvent.start }}</h3>
              </v-card-text>
              <v-card-text>
                <h3>End : {{ selectedEvent.end }}</h3>
              </v-card-text>
            </div>

            <v-card-actions>
              <v-btn text color="secondary" @click="selectedOpen = false">
                Cancel
              </v-btn>
            </v-card-actions>

            <modal
              v-if="showModal"
              @close="showModal = false"
              class="justify-center align-center"
            >
              <span class="text-center align-center align-content-center"
                ><h3 slot="header">Edit workingtimes</h3> </span
              >
  
              <div class="d-flex align-center boxEdit">

                <div class="inputEditBox">
                  <v-menu
                  class="dateBox"
                    ref="menuStartDate"
                    v-model="menu"
                    :close-on-content-click="false"
                    :return-value.sync="dateRangeText"
                    transition="scale-transition"
                    offset-y
                    min-width="auto"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field
                        v-model="dateRangeText"
                        label="Picker in menu date"
                        prepend-icon="mdi-calendar"
                        v-bind="attrs"
                        v-on="on"
                      ></v-text-field>
                     
                    </template>

                    <v-date-picker v-model="lastDate" no-title scrollable range>
                      <v-spacer></v-spacer>
                      <v-btn text color="primary" @click="menuStartDate = false">
                        Cancel
                      </v-btn>
                      <v-btn
                        text
                        color="primary"
                        @click="$refs.menuStartDate.save(lastDate)"
                      >
                        OK
                      </v-btn>
                    </v-date-picker>
                  </v-menu>
                  <div class="d-flex " >
                  <v-menu
                        ref="menuStartTime"
                        v-model="clockStart"
                        :close-on-content-click="false"
                        :nudge-right="40"
                        :return-value.sync="time"
                        transition="scale-transition"
                        offset-y
                        max-width="300px"
                        min-width="290px"
                  >
                          <template v-slot:activator="{ on, attrs }">
                            <v-text-field
                              v-model="lastTime[0]"
                              label="start time"
                              prepend-icon="mdi-clock-time-four-outline"
                              readonly
                              v-bind="attrs"
                              v-on="on"
                            ></v-text-field>
                            
                          </template>
                          <v-time-picker
                            use-seconds
                            v-if="clockStart"
                            v-model="lastTime[0]"
                            full-width
                            @click:minute="$refs.menuStartTime.save(lastTime[0])"
                          ></v-time-picker>
                          <v-spacer></v-spacer>
                          <v-btn text color="primary" @click="modal2 = false">
                            Cancel
                          </v-btn>
                          <v-btn
                            text
                            color="primary"
                            @click="$refs.dialog.save(lastTime[0])"
                          >
                            OK
                          </v-btn>
                  </v-menu>

                        <v-menu
                        ref="menuEndTime"
                        v-model="clockEnd"
                        :close-on-content-click="false"
                        :nudge-right="40"
                        :return-value.sync="time"
                        transition="scale-transition"
                        offset-y
                        max-width="300px"
                        min-width="290px"
                      >
                          <template v-slot:activator="{ on, attrs }">
                            <v-text-field
                              v-model="lastTime[1]"
                              label="end time"
                              prepend-icon="mdi-clock-time-four-outline"
                              readonly
                              v-bind="attrs"
                              v-on="on"
                            ></v-text-field>
                            
                          </template>
                          <v-time-picker
                            use-seconds
                            v-if="clockEnd"
                            v-model="lastTime[1]"
                            full-width
                            @click:minute="$refs.menuEndTime.save(lastTime[1])"
                          ></v-time-picker>
                          <v-spacer></v-spacer>
                          <v-btn text color="primary" @click="modal3 = false">
                            Cancel
                          </v-btn>
                          <v-btn
                            text
                            color="primary"
                            @click="$refs.dialog.save(lastTime[1])"
                          >
                            OK
                          </v-btn>
                      </v-menu>
                  </div>
                  <span >
                    <v-btn
                    @click="editWorkingtimes"
                    class="btnEdit"
                      elevation="6"
                      outlined
                    >Confirm</v-btn>
                  </span>
                </div>

              </div>
            </modal>
          </v-card>
        </v-menu>
      </div>
    </v-list>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import Vue from "vue";

export default {
  name: "WorkingTimes",
  data() {
    return {
      absolute: true,
      showModal: false,
      data_workingtimes: {},
      test: [],
      ttest: [],
      worksdays: [],
      yearSelectedCheck: false,
      yearSelected: "",
      daySelected: "",
      day: [],
      month: [],
      months: [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      ],
      days: [
        " ",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ],
      years: [" "],
      focus: "",
      type: "month",
      typeToLabel: {
        month: "Month",
        week: "Week",
        day: "Day",
        "4day": "4 Days",
      },
      selectedEvent: {},
      selectedElement: null,
      selectedOpen: false,
      dataWorks: [],
      events: [],
      colors: [
        "blue",
        "indigo",
        "deep-purple",
        "cyan",
        "green",
        "orange",
        "grey darken-1",
      ],
      newStartdate: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10),
       newEnddate: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10),
        lastDate:['',''],
        lastTime:['',''],
      lastStart: "",
      lastEnd: "",
      timeStart:null,
      timeEnd: null,
      clockStart: false,
      clockEnd:false,
      modal2:false,
      modal3:false,
      newStartDate:'',
      newEndDate:'',
      newWorking:{start:'',end:''},
      WorkingId:''
    };
  },
  watch: {
    overlay(val) {
      val &&
        setTimeout(() => {
          this.overlay = false;
        }, 2000);
    },
  },
  created() {
   

    this.GetWorkingTImes();
    this.getYears();
  },

  methods: {
    pushWorks(month, works, day) {
      let Color = this.colors[this.rnd(0, this.colors.length - 1)];
      this.ttest.push({
        monthName: month,
        worksdate: works,
        dayName: day,
        color: Color,
      });
    },
    getYears() {
      let currentYear = new Date().getFullYear();
      let min = currentYear - 5;
      for (let i = currentYear; i >= min; i--) {
        this.years.push(i);
      }
    },
    async GetWorkingTImes() {
      axios
        .get(
          "http://localhost:4000/api/workingtimes/" + this.$store.state.user.id
        )
        .then((res) => {
          this.data_workingtimes = res.data.data;

          res.data.data.forEach((elmt) => {
            let getdaystart = elmt.start.split("T");
            let getdayEnd = elmt.end.split("T");
            let date_Formated = moment(getdaystart[0]).format("YYYY-MM-DD");
            let date_FormatedEnd = moment(getdayEnd[0]).format("YYYY-MM-DD");

            let strStart = date_Formated + " " + getdaystart[1];
            let strEnd = date_FormatedEnd + " " + getdayEnd[1];
            const allDay = this.rnd(0, 3) === 0;
            this.dataWorks.push({
              start: strStart,
              end: strEnd,
              color: this.colors[this.rnd(0, this.colors.length - 1)],
              timed: !allDay,
              id: elmt.id,
            });

            let month_date = date_Formated.split(" ");
            let month_date_end = date_FormatedEnd.split(" ");

            let startDay = month_date[0];
            let endDay = month_date_end[0];

            this.worksdays.push({ start: elmt.start });
            this.worksdays.push({ end: elmt.end });

            this.worksdays.push({ day: month_date });
            this.worksdays.push({ dayStart: startDay });
            this.worksdays.push({ dayEnd: endDay });

            this.worksdays.push({ yearEnd: month_date_end[2] });
            this.worksdays.push({ yearStart: month_date[2] });

            this.worksdays.push(elmt.id);

            let currentday = month_date[0];
            this.nbWorks++;
            this.pushWorks(month_date[1], this.worksdays, currentday);
            this.worksdays = [];
          });

          let test = this.data_workingtimes.map((data) => {
            let str_date = data.start.split("T");

            let dateFormated = moment(str_date[0]).format("dddd MMMM YY");

            let getday = dateFormated.split(" ");

            this.day.push(getday[0]);

            this.month.push(getday[1]);
            this.data_formated = dateFormated;
          });
          return test;
        })
        .catch((e) => {
          console.error(e);
        });
    },
    showWorkingTimes() {
      let demo = new Vue({
        el: "#demof",
        data: {
          parentMsg: "YO",
          items: this.ttest,
        },
      });
      return demo;
    },

    selectDay(d) {
      this.daySelected = d;
    },
    selectYear(y) {
      this.yearSelected = y;
    },
    setToday() {
      this.focus = "";
      console.log(this.focus);
    },
    getEventColor(event) {
      return event.color;
    },
    viewDay({ date }) {
      this.focus = date;
    },
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event;
        this.selectedElement = nativeEvent.target;
              this.lastDate[0]=event.start.split(" ")[0]
              this.lastDate[1]=event.end.split(" ")[0]
              this.lastTime[0]=event.start.split(" ")[1]
              this.lastTime[1]=event.end.split(" ")[1]
              this.WorkingId=event.id
        requestAnimationFrame(() =>
          requestAnimationFrame(() => (this.selectedOpen = true))
        );
      };

      if (this.selectedOpen) {
        this.selectedOpen = false;
        requestAnimationFrame(() => requestAnimationFrame(() => open()));
      } else {
        open();
      }

      nativeEvent.stopPropagation();
    },
    updateRange() {
      const events = [];

      this.dataWorks.forEach((el) => {
        const allDay = this.rnd(0, 3) === 0;
        let startTime = el.start;
        let endTime = el.end;
        events.push({
          start: startTime,
          end: endTime,
          color: this.colors[this.rnd(0, this.colors.length - 1)],
          timed: !allDay,
          id: el.id,
        });
      });

      this.events = events;
    },
    rnd(a, b) {
      return Math.floor((b - a + 1) * Math.random()) + a;
    },
    editWorkingtimes() {

            let strt = this.lastDate[0]+" "+this.lastTime[0]
            let end = this.lastDate[1]+" "+this.lastTime[1]
            this.newStartDate=this.lastDate[0]
             this.newStartDate=this.newStartDate+' '
              this.newStartDate=this.newStartDate+this.lastTime[0]
           this.newEndDate=this.lastDate[1]
          this.newEndDate=this.newEndDate+' '
           this.newEndDate=this.newEndDate+this.lastTime[1]
  
             if(confirm("Do you really want to edit this workingtime?")){
                this.newWorking.start=strt
                this.newWorking.end=end
                let workingtime= this.newWorking
              
              axios.put('http://localhost:4000/api/workingtimes/'+this.WorkingId,
                {workingtime},
                )
                .then(resp => {
                    console.log(resp)
                })
                .catch(error => {
                    console.log(error);
                })
   }

    }
  },
  computed: {
    dateRangeText () {
        return this.lastDate.join(' ~ ')
      },
    eventsMap() {
      const map = {};
      this.dataWorks.forEach((e) =>
        (map[e["worksdate"]] = map[e["worksdate"]] || []).push(e)
      );

      return map;
    },
  },
  mounted() {
    this.$refs.calendar.checkChange();
  },
};
</script>

<style scoped>
.working-times {
  height: 100%;
}
.mycard {
  height: 65vh;
}
.listCard {
  height: 35vh;
}
.itemCard {
  background-color: cornflowerblue;
  height: 55%;
  width: 85%;
  border: 3;
  margin: 5%;

  border-radius: 20;
}
.btnYear {
  margin: 2%;
}
.boxEdit {
  width: 100%;

}
.btnEdit {
  margin-left: 45%;

}
.cardWorks {
  width: 90%;
  height: 8%;
  flex-direction: row;
  margin: 1%;
}
.cardWorkst {
  width: 100%;
  flex-direction: row;
  background-color: rgb(37, 209, 157);
}
.scroller {
  height: 100%;
  width: 100%;
}
.inputEdit {
  width: 70%;
}
.inputEditBox {
  padding:2%;
align-self: center;
  width: 100%;
}
.datebox {
  width:100%;
  text-align: center;
  align-content: center;
  /* background-color: crimson; */
  height: 100%;
}
.startdate {
  font-size: 20;
  background-color: yellow;
}
.enddate {
  font-size: 20;
  width: "30%";
  background-color: green;
}
.headpanel {
  justify-content: center;
  text-align: center;
  background-color: rgb(37, 209, 157);
}
.yearsbox {
  height: 15%;
  margin-top: 0.5%;
}
.teest {
  background-color: blueviolet;
}
.selectDay {
  width: 8%;
  margin-right: 1%;
  margin-left: 1%;
}
.selectYear {
  width: 10%;
  margin-right: 1%;
}

</style>