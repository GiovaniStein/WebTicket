function removeTarefa(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover essa tarefa?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sim',
        cancelButtonText: 'Não'
    }).then(function (isConfirm) {
        if (isConfirm.value) {
            $.ajax({
                type: "GET",
                url: '/WebTicket/acao?parametro=exTarefa&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover tarefa!", resultado, "error");
                } else {
                    swal("Tarefa removida com sucesso!", "", "success");
                    $("#listaTarefasContainer").load("listaTarefas.jsp");
                    $("#buttonPesquisar").click();
                }
            });
            return false;
        }
    });
}

function editTarefa(element) {
    var value = $(element).val();
    window.location.href = "/WebTicket/acao?parametro=edTarefa&id=" + value;
}

function readTarefa(element) {
    var value = $(element).val();
    var modal = document.getElementById('myModal');
    modal.style.display = "block";


    var values = {};
    $.ajax({
        type: "GET",
        url: "/WebTicket/acao?parametro=taskInformation&id=" + value,
        data: $('form').serialize()
    }).done(function (retorno) {
        var resultado = $.trim(retorno);
        values = JSON.parse(resultado);
        $('#tasktitle')[0].innerHTML = values.titulo;
        $('#tasktitle')[0].title = values.titulo;
        $('#taskdescription')[0].innerHTML = values.descricao;
        $('#taskclient')[0].innerHTML = values.cliente;
        $('#taskproject')[0].innerHTML = values.projeto;
        $('#taskmodule')[0].innerHTML = values.modulo;
        $('#taskcreatedate')[0].innerHTML = values.datacriacao;
        console.log('movimentacoes ', values);
        var data = values.movimentacoes;
        var cityTable = makeTable($('#tasktablecontainer'), data);
    });


    var span = document.getElementsByClassName("close")[0];
    span.onclick = function () {
        modal.style.display = "none";
        $("#taskmov > tr").remove();
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
            $("#taskmov > tr").remove();
        }
    }
}

function makeTable(container, data) {
    var table = $("#taskmov").addClass('CSSTableGenerator');
    var row = $("<tr/>");
    row.append($("<th" + "/>").text('Movimentações'));
    table.append(row);

    if (data.length > 0) {
        $.each(data, function (rowIndex, r) {
            var row = $("<tr/>");
            var td = $("<td" + "/>");
            td.text(r);
            td.css("word-wrap", "break-word");
            row.append(td);
            table.append(row);
        });
    } else {
        var row = $("<tr/>");
        var td = $("<td" + "/>");
        td.text('Não há movimentações para essa tarefa');
        td.css("word-wrap", "break-word");
        row.append(td);
        table.append(row);
    }
    return container.append(table);
}


$(function () {
    //Initialize Select2 Elements
    $('.select2').select2()

    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'})
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', {'placeholder': 'mm/dd/yyyy'})
    //Money Euro
    $('[data-mask]').inputmask()

    //Date range picker
    $('#reservation').daterangepicker()
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'})
    //Date range as a button
    $('#daterange-btn').daterangepicker(
            {
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                startDate: moment().subtract(29, 'days'),
                endDate: moment()
            },
            function (start, end) {
                $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
            }
    )

    //Date picker
    $('#datepicker').datepicker({
        autoclose: true
    })

    //iCheck for checkbox and radio inputs
    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        radioClass: 'iradio_minimal-blue'
    })
    //Red color scheme for iCheck
    $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
        checkboxClass: 'icheckbox_minimal-red',
        radioClass: 'iradio_minimal-red'
    })
    //Flat red color scheme for iCheck
    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-green',
        radioClass: 'iradio_flat-green'
    })

    //Colorpicker
    $('.my-colorpicker1').colorpicker()
    //color picker with addon
    $('.my-colorpicker2').colorpicker()

    //Timepicker
    $('.timepicker').timepicker({
        showInputs: false
    })
})
