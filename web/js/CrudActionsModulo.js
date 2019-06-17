$(document).ready(function () {
    $('#cadastraModulo').click(function (event) {
        event.preventDefault();
        if (valida_form_modulo() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadModulo",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formModulo').each(function () {
                        this.reset();
                    });
                    $("#listadeModulos").load("listaModulos.jsp");
                    $('#selectProjeto').val(0).change();
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form_modulo() {
    if ((document.getElementById("moduloDescricao").value === null || document.getElementById("moduloDescricao").value === "") ||
            (document.getElementById("selectProjeto").value === '0' || document.getElementById("selectProjeto").value === "")) {
        return false;
    } else {
        return true;
    }
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
    });
});

function removeModulo(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover esse modulo?",
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
                url: '/WebTicket/acao?parametro=exModulo&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover modulo!", resultado, "error");
                } else {
                    swal("Modulo removido com sucesso!", "", "success");
                    $("#listadeModulos").load("listaModulos.jsp");
                }
            });
            return false;
        }
    });
}

function editModulo(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idmodulo').val(td[0].innerText);
    $('#moduloDescricao').val(td[1].innerText);
    var select = $('#selectProjeto').children();

    for (var x = 0; x < select.length; x++) {
        if (select[x].text === td[2].innerText) {
            $('#selectProjeto ').val(select[x].value).change();
        }
    }
}




