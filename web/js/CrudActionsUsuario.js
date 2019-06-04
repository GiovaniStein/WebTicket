$(document).ready(function () {
    $('#cadastraUsuario').click(function (event) {
        var resultado = "";
        event.preventDefault();
        if (valida_form_usuario() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadUsuario",
                data: $('form').serialize()
            }).done(function (retorno) {
                resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#loginUsuario').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formusuario').each(function () {
                        this.reset();
                    });
                    $("#listadeUsuarios").load("listaUsuarios.jsp");
                }
            });
            $('#nomeUsuario').focus();
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form_usuario() {
    if ((document.getElementById("nomeUsuario").value == null || document.getElementById("nomeUsuario").value == "") || (document.getElementById("loginUsuario").value == null || document.getElementById("loginUsuario").value == "") || (document.getElementById("senhaUsuario").value == null || document.getElementById("senhaUsuario").value == "") || (document.getElementById("repetirSenhaUsuario").value == null || document.getElementById("repetirSenhaUsuario").value == "")) {
        return false
    } else {
        return true
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

function removeUser(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover esse usuário?",
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
                url: '/WebTicket/acao?parametro=exUsuario&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover usuário!", resultado, "error");
                } else {
                    swal("Usuário removido com sucesso!", "", "success");
                    $("#listadeUsuarios").load("listaUsuarios.jsp");
                }
            });
            return false;
        }
    });
}
function editUser(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idUsuario').val(td[0].innerText);
    $('#nomeUsuario').val(td[1].innerText);
    $('#loginUsuario').val(td[2].innerText);
}


