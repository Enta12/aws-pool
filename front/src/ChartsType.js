let BarChart = {
    type: "bar",
        data: {
        labels: ["Temps passé au travail sur la semaine", "Temps voulu", "Temps restant"],
            datasets: [
            {
                label: "Vous",
                data: [14, 40, 26],
                backgroundColor: "rgba(54,73,93,.5)",
                borderColor: "#36495d",
                borderWidth: 3
            },
            {
                label: "Utilisateurs",
                data: [18, 40, 24],
                backgroundColor: "rgba(13,178,13,.5)",
                borderColor: "#36495d",
                borderWidth: 3
            }

        ]
    },
    options: {
        responsive: true,
            lineTension: 1,
            scales: {
            yAxes: [
                {
                    ticks: {
                        beginAtZero: true,
                        padding: 25
                    }
                }
            ]
        }
    }
}

let LineChart = {
  type : 'line',
  data: {
    labels: [
        '00h00',
        '01h00',
        '02h00',
        '03h00',
        '04h00',
        '05h00',
        '06h00',
        '07h00',
        '08h00',
        '09h00',
        '10h00',
        '11h00',
        '12h00',
        '13h00',
        '14h00',
        '15h00',
        '16h00',
        '17h00',
        '18h00',
        '19h00',
        '20h00',
        '21h00',
        '22h00',
        '23h00',
        '00h00',
    ],
    datasets: [{
        label: 'My First dataset',
        backgroundColor: 'rgb(255, 99, 132)',
        borderColor: 'rgb(255, 99, 132)',
        data: [0, 10, 5, 2, 20, 30, 45],
      }]
  },
  options : {

  }
}

let PieChart = {
    type : "pie",
    data : {
        labels: [
            'Red',
            'Blue',
            'Yellow'
        ],
        datasets: [{
            label: 'ouais ouais',
            data: [300, 50, 100],
            backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)',
                'rgb(255, 205, 86)'
            ],
            hoverOffset: 4
        }]
    }
}

export {BarChart, LineChart, PieChart}