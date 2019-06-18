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
        $.ajax({
            type: "GET",
            url: "/WebTicket/acao",
            data: {parametro:"comboData",id:id},
            dataType : 'json'
        }).done(function (retorno) {
            
            var modulo = Object.values(retorno.modulo);
            var versao = Object.values(retorno.versao);

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
        
        
        var text = '';
        
        item.descricao.map(x => text = text+String.fromCharCode(x));
        
        console.log('item ',item);
        
        if(value+''===item.id+'' && value!==0){
            $(elementId).append($('<option>', {
            value: item.id,
            text: text,
            selected: 'selected'
        }));
        }else{
           $(elementId).append($('<option>', {
            value: item.id,
            text: text
        })); 
        }
        
       
    });
}


