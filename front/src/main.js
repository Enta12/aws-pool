import Vue from 'vue'
import App from './App.vue'
import store from "./store/Store";
import vuetify from './plugins/vuetify'
import VueRouter from 'vue-router'
import User from "./components/User";
import Login from "./components/Login";
import Charts from "./components/Charts";
import workForm from "./components/workForm";
import Home from "./components/Home";
import workFormCalendar from "./components/workFormCalendar";
import Admin from "./components/Admin";
Vue.config.productionTip = false

Vue.use(VueRouter)

const routes = [
  { path: '/User', component: User },
  { path: '/Login', component: Login },
  { path: '/Chart', component: Charts },
  { path: '/workForm', component: workForm },
  { path: '/Home', component: Home },
  { path: '/', component: Home },
  { path: '/workFormCalendar', component: workFormCalendar },
  { path: '/Admin', component: Admin },
]

const router = new VueRouter({
  routes // short for `routes: routes`
})

new Vue({
  render: h => h(App),
  vuetify,
  router,
  store: store
}).$mount('#app')
