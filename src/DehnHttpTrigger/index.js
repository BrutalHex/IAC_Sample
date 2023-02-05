var azure = require('azure-storage');

function callBlob(container,blob ) {
    return new Promise((resolve, reject)  => {

              var blobSvc = azure.createBlobService( process.env["AZURE_STORAGE_ACCOUNT"],   process.env["AZURE_STORAGE_ACCESS_KEY"]);
              blobSvc.getBlobToText(container, blob,(error, text) => {
                 
                   
                  if(!error){
                        resolve(text);
                  }
                  else
                  {
                    console.error(error);
                    reject(error);
          
                  }
                });





    });
  }




module.exports = async function (context, req) {
 

 
 

    var text= await callBlob( process.env["AZURE_STORAGE_CONTAINER"], process.env["AZURE_STORAGE_BLOB"]);

     
   
    context.res = {
        // status: 200, /* Defaults to 200 */
        body: `${text} \n ${process.env["SELECTED_ENV"]}` 
    };
}