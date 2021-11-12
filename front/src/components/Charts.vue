<template>
  <v-container fill-height>
    <v-tabs grow>
      <v-tab v-on:click="PutLineChart" >Line Chart</v-tab>
      <v-tab v-on:click="PutBarChart">Bar Chart</v-tab>
      <v-tab v-on:click="PutPieChart">Pie Chart</v-tab>
    </v-tabs>
      <v-col class="fill-height">
        <v-row align="center" justify="center">
              <canvas style="max-height: 600px; max-width: 80%" id="planet-chart"></canvas>
        </v-row>
        <v-row class="mt-10">
            <v-card elevation="6" style="margin: auto">
              <v-card-title class="justify-center">CHART PANNEL</v-card-title>
              <v-card-actions>
                <v-btn v-on:click="ChangeForDay">Voir pour la journée</v-btn>
                <v-btn>Voir pour la semaine</v-btn>
              </v-card-actions>
            </v-card>
        </v-row>
      </v-col>
    </v-container>
</template>

<script>
import {Chart, registerables} from 'chart.js'
import {BarChart, LineChart, PieChart} from "../ChartsType";
//import {GetAllWorkingTimes, getDateTime} from "../storeUtils/StoreUtils";

Chart.register(...registerables)

export default {
  name: 'ChartBasic',
  data() {
    return {
      DataChart : {},
      mychart : null,
      actual_canva : 0
    }
  },
  methods : {
    async ChangeForDay() {
      let response;
      if (this.actual_canva === 0) {
        this.DataChart.data.datasets[0].data
        response = await fetch("http://ligne7.pepintrie.fr:4000/api/workingtimes/" + this.$store.state.user.id, {method : "GET"}).then((res) => {
          return res.json()
        }).catch((err) => {
          console.log("ERROR = ", err)
        })}
      console.log(response)
    },
    async ChangeForWeek() {
      let response;
      if (this.actual_canva === 0) {
        response = await fetch("http://ligne7.pepintrie.fr:4000/api/workingtimes/" + this.$store.state.user.id, {method : "GET"}).then((res) => {
          return res.json()
        }).catch((err) => {
          console.log(err)
        })}
      console.log(response)
    },
    PutLineChart() {
      this.DataChart = LineChart
      this.mychart.destroy()
      const ctx = document.getElementById('planet-chart');
      this.mychart = new Chart(ctx, this.DataChart);
      this.actual_canva = 0
    },
    PutBarChart() {
      this.DataChart = BarChart
      this.mychart.destroy()
      const ctx = document.getElementById('planet-chart');
      this.mychart = new Chart(ctx, this.DataChart);
      this.actual_canva = 1
    },
    PutPieChart() {
      this.DataChart = PieChart
      this.mychart.destroy()
      const ctx = document.getElementById('planet-chart');
      this.mychart = new Chart(ctx, this.DataChart);
      this.actual_canva = 2
    }
  },
  mounted() {
    this.DataChart = LineChart
    const ctx = document.getElementById('planet-chart');
    this.mychart = new Chart(ctx, this.DataChart);
  }
}
</script>

<style>
.size {
  margin: auto;
  max-height: 30vh;
  max-width: 30vw;
}
</style>