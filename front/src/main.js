import Vue from 'vue'
import App from './App.vue'
import store from "./store/Store";
import vuetify from './plugins/vuetify'
import VueRouter from 'vue-router'
import User from "./components/User";
import Login from "./components/Login";
import Charts from "./components/Charts";
import Home from "./components/Home";
import workFormCalendar from "./components/workFormCalendar";
import Admin from "./components/Admin";
Vue.config.productionTip = false

Vue.use(VueRouter)

const routes = [
  { path: '/User', component: User},
  { path: '/Login', component: Login},
  { path: '/Chart', component: Charts },
  { path: '/Home', component: Home },
  { path: '/', component: Home },
  { path: '/workFormCalendar', component: workFormCalendar },
  { path: '/Admin', component: Admin, name : "Admin"},
]

const router = new VueRouter({
  routes // short for `routes: routes`
})

router.beforeEach((to, from, next) => {
  console.log(store.state.user.isLoggedIn, to.path)
  if (to.path !== "/Login" && store.state.user.isLoggedIn === false)
    next({ path: '/Login' })
  else next()
})


new Vue({
  render: h => h(App),
  vuetify,
  router,
  store: store
}).$mount('#app')
