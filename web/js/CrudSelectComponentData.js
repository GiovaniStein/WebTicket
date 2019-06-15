$(document).ready(function () {
   changeData();
});


function changeData() {
    $('#selectModulo').empty();
    $('#selectVersao').empty();
    $('#selectVersaoCorrecao').empty();
    $('#selectModulo').append($('<option>', {value: 0, text: 'Selecione um projeto'}));
    $('#selectVersao').append($('<option>', {value: 0, text: 'Selecione um projeto'}));
    $('#selectVersaoCorrecao').append($('<option>', {value: 0, text: 'Selecione um projeto'}));
    $('#selectModulo').attr('disabled', 'disabled');
    $('#selectVersao').attr('disabled', 'disabled');
    $('#selectVersaoCorrecao').attr('disabled', 'disabled');
    
   

    var id = $('#selectProjeto').val();

    if (id !== '0') {
        var values = {};
        $.ajax({
            type: "GET",
            url: "/WebTicket/acao?parametro=comboData&id=" + id,
            data: $('form').serialize()
        }).done(function (retorno) {
            var resultado = $.trim(retorno);
            values = JSON.parse(resultado);

            var modulo = Object.values(values.modulo);
            var versao = Object.values(values.versao);

            createOptionsElements('#selectModulo', modulo);
            createOptionsElements('#selectVersao', versao);
            createOptionsElements('#selectVersaoCorrecao', versao);
        });
    }
    
}

function createOptionsElements(elementId, items) {


    if (items.length > 0) {
        $(elementId).empty();
        $(elementId).removeAttr('disabled');
        $(elementId).append($('<option>', {
            value: 0,
            text: 'Selecione'
        }));
    } else {
        $(elementId).empty();
        $(elementId).append($('<option>', {
            value: 0,
            text: 'Sem dados cadastrados'
        }));
    }
    
    
    $.each(items, function (i, item) {
        
        var value = $(elementId+'Value').val();
        
        if(value+''===item.id+'' && value!==0){
            $(elementId).append($('<option>', {
            value: item.id,
            text: item.descricao,
            selected: 'selected'
        }));
        }else{
           $(elementId).append($('<option>', {
            value: item.id,
            text: item.descricao
        })); 
        }
        
       
    });
}


