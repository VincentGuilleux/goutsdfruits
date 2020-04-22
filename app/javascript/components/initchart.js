import Chart from "chart.js"
export const InitChart = () => {
  const ctx = document.getElementById('vente_chart').getContext('2d');
  const chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'line',

      // The data for our dataset
      data: {
          labels: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin'],
          datasets: [{
              label: '2019',
              backgroundColor: 'rgb(255, 99, 132)',
              borderColor: 'rgb(255, 99, 132)',
              data: [0, 10, 5, 2, 20, 30]
          },
          {
              label: '2020',
              backgroundColor: 'rgb(255, 255, 132)',
              borderColor: 'rgb(255, 255, 132)',
              data: [0, 4, 8, 2]
          }]
      },

      // Configuration options go here
      options: {
        scales: {
          xAxes: [{
            gridLines: {
              drawOnChartArea: false
            }
          }],
          yAxes: [{
            gridLines: {
              drawOnChartArea: false
            }
          }]
        }
      }
});
}
