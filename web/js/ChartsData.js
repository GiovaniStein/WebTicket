$(document).ready(function () {
    var values = {};
    $.ajax({
        type: "GET",
        url: "/WebTicket/acao?parametro=appInformation",
        data: $('form').serialize()
    }).done(function (retorno) {
        var resultado = $.trim(retorno);
        values = JSON.parse(resultado);
        console.log(values);

        var projectsnames = Object.getOwnPropertyNames(values.tasksPerProject);
        var projectvalues = Object.values(values.tasksPerProject);
        var stepnames = Object.getOwnPropertyNames(values.tasksPerStep);
        var stepvalues = Object.values(values.tasksPerStep);
        var ctx = document.getElementById('barChartContainer').getContext('2d');
        var ctx2 = document.getElementById('pieChartContainer').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: projectsnames,
                datasets: [{
                        label: 'Nº de projetos',
                        data: projectvalues,
                        backgroundColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                }
            }
        });
        var myChart2 = new Chart(ctx2, {
            type: 'pie',
            data: {
                labels: stepnames,
                datasets: [{
                        label: '',
                        data: stepvalues,
                        backgroundColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                }
            }
        });
    });

});


