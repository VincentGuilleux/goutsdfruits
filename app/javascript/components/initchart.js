import Chart from "chart.js"

let chart;

export const InitChart = () => {
  // destroy previous chart if present
  if (chart) {
    chart.destroy();
    chart = null;
  }

  const container = document.getElementById('chartContainer');
  if (!container) return;

  // container.style.width  = `${container.parentElement.clientWidth}px`;
  // container.style.height = `${container.parentElement.clientHeight}px`;
  container.innerHTML = `<canvas id="vente_chart"</canvas>`;

  setTimeout(() => {
    const ctx = document.getElementById('vente_chart').getContext('2d');
    const chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'line',

      // The data for our dataset
      data: {
        labels: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
        datasets: [
          {
            label: '2019',
            borderColor: 'rgb(255, 99, 132)',
            data: monthly_order_values_previous_year,
            fill: false,
            lineTension: 0
          },
          {
            label: '2020',
            borderColor: 'rgb(118, 190, 208)',
            // data: [antePreviousMonthTurnover, previousMonthTurnover, currentMonthTurnover],
            data: monthly_order_values,
            fill: false,
            lineTension: 0
          }
        ]
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
            },
            ticks: {
               display: false
            }
          }]
        }
      }
    });
  }, 0);
};
