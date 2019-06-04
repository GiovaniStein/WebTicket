$(document).ready(function () {
    $('#cadastraCliente').click(function (event) {
        event.preventDefault();
        if (valida_form_cliente() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadCliente",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formCliente').each(function () {
                        this.reset();
                    });
                    $("#listadeCliente").load("listaClientes.jsp");
                    $('#clienteCidade').val(0).change();
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});


function removeCliente(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover esse cliente?",
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
                url: '/WebTicket/acao?parametro=exCliente&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover cliente!", resultado, "error");
                } else {
                    swal("Cliente removido com sucesso!", "", "success");
                    $("#listadeCliente").load("listaClientes.jsp");
                }
            });
            return false;
        }
    });
}

function editCliente(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    var type = "";
    $('#idCliente').val(td[0].innerText);
    $('#clienteNome').val(td[1].innerText);
    if (td[2].innerText.length === 11) {
        $('#cpf').val(td[2].innerText);
        type = "F";
    }
    if (td[2].innerText.length === 14) {
        $('#cnpj').val(td[2].innerText);
        type = "J";
    }

    $('#clienteEndereco').val(td[3].innerText);
    var select = $('#tipo').children();


    for (var x = 0; x < select.length; x++) {
        if (select[x].value === type) {
            $('#tipo').val(select[x].value).change();
        }
    }

    select = $('#clienteCidade').children();

    for (var x = 0; x < select.length; x++) {
        if (select[x].text === td[4].innerText) {
            $('#clienteCidade').val(select[x].value).change();
        }
    }

    $('#clienteTelefone').val(td[5].innerText);


}



function valida_form_cliente() {
    if ((document.getElementById("clienteNome").value === null || document.getElementById("clienteNome").value === "") ||
            (document.getElementById("tipo").value === null || document.getElementById("tipo").value === "") ||
            (document.getElementById("clienteTelefone").value === null || document.getElementById("clienteTelefone").value === "") ||
            (document.getElementById("clienteCidade").value === null || document.getElementById("clienteCidade").value === "") ||
            (document.getElementById("clienteEndereco").value === null || document.getElementById("clienteEndereco").value === "")) {
        return false;
    } else {
        return true;
    }
}


$(function () {
    //Initialize Select2 Elements
    $(".select2").select2();
    //Money Euro
    $("[data-mask]").inputmask();
    //Desabilita e habilita conforme a manutencao
    $(document).ready(ajustaInterface);
    $(document).ready(habilitarCampos);
    //Ajusta o CNPJ/CPF conforme o tipo de pessoa
    $("#tipo").on("change", ajustaInterface);
});
function ajustaInterface() {
    if ($("#tipo").val() === 'F') {
        $("#grupo_cnpj").hide();
        $("#grupo_cpf").show();
        $("#cnpj").prop('required', false);
        $("#cpf").prop('required', true);
    } else {
        $("#grupo_cnpj").show();
        $("#grupo_cpf").hide();
        $("#cnpj").prop('required', true);
        $("#cpf").prop('required', false);
    }
}

function habilitarCampos() {
    if ($("#id").val() == 0) {
        $("#tipo").prop("disabled", false);
    } else {
        $("#tipo").prop("disabled", false);
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
    })
})