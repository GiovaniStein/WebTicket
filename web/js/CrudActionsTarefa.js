$(document).ready(function () {
    $('#cadastraTarefa').click(function (event) {
        event.preventDefault();

        var descricao = CKEDITOR.instances.editor1.getData();

        $('#idDescricao').val(descricao);
        
        if (valida_form_tarefa() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadTarefa",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#cadTarefa').each(function () {
                        this.reset();
                    });
                    $('#selectCliente').val(0).change();
                    $('#selectAutor').val(1).change();
                    $('#selectResponsavel').val(0).change();
                    $('#selectProjeto').val(0).change();
                    $('#selectMotivo').val(0).change();
                    $('#selectModulo').val(0).change();
                    $('#selectFase').val(0).change();
                    $('#selectPrioridade').val(0).change();
                    $('#selectVersao').val(0).change();
                    $('#selectVersaoCorrecao').val(0).change();
                    $('#dataPrevisao').val('');
                    $('#datahoraCriacao').val('');
                    $('#tituloTarefa').val('');
                    $('#idTarefa').val('');
                    $('#listaMovimentacoes').empty();
                    
                    CKEDITOR.instances.editor1.setData('');
                }
            });
            return false;

        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});



function valida_form_tarefa() {
    if ((document.getElementById("selectCliente").value === '0' || document.getElementById("selectCliente").value === "") ||
            ((document.getElementById("selectAutor").value === '0' || document.getElementById("selectAutor").value === "")) ||
            ((document.getElementById("selectResponsavel").value === '0' || document.getElementById("selectResponsavel").value === "")) ||
            ((document.getElementById("selectProjeto").value === '0' || document.getElementById("selectProjeto").value === "")) ||
            ((document.getElementById("selectMotivo").value === '0' || document.getElementById("selectMotivo").value === "")) ||
            ((document.getElementById("selectModulo").value === '0' || document.getElementById("selectModulo").value === "")) ||
            ((document.getElementById("selectFase").value === '0' || document.getElementById("selectFase").value === "")) ||
            ((document.getElementById("selectPrioridade").value === '0' || document.getElementById("selectPrioridade").value === "")) ||
            ((document.getElementById("selectVersao").value === '0' || document.getElementById("selectVersao").value === "")) ||
            ((document.getElementById("selectVersaoCorrecao").value === '0' || document.getElementById("selectVersaoCorrecao").value === "")) ||
            ((document.getElementById("dataPrevisao").value === '' || document.getElementById("dataPrevisao").value === null)) ||
            ((document.getElementById("tituloTarefa").value === '' || document.getElementById("tituloTarefa").value === null)) ||
            ((CKEDITOR.instances.editor1.getData( ) === '' || CKEDITOR.instances.editor1.getData() === null))) {
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


