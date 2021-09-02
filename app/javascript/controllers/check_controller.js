import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "transfer","bank","class","type", "from"]
initialize(){
    console.log("Iam Check")
}
  addfield(){
    console.log("Yahan")
    this.addTarget.classList.remove("hidden");
//     var txtNewInputBox = document.createElement('div');
// // Then add the content (a new input box) of the element.
//     txtNewInputBox.innerHTML = "<input type='text' id='newInputBox'>";
// // Finally put it where it is supposed to appear.
//     document.getElementById("newElementId").appendChild(txtNewInputBox);
}
hidefield(){
    this.addTarget.classList.add("hidden");
}
  toggleTransaction(event) {
        if(this.bankTarget.selectedIndex === this.bankTarget.length - 1)
            this.fromTarget.lastElementChild.value = "Wallet"
            //document.getElementById('transaction_transfer_from_type').value = "Wallet";
        else
            this.fromTarget.lastElementChild.value = "BankAccount";
        
    }
    toggle(){
        if(this.typeTarget.value === "BankTransfer"){
            //console.log(this.classTarget.lastElementChild.value)
            this.classTarget.classList.remove("hidden");
            //console.log(this.transferTarget.options[this.bankTarget.length-1])
            if(this.fromTarget.lastElementChild.value === "Wallet"){
                this.transferTarget.options[this.bankTarget.length-1].disabled = true
                for(var i = 0; i < this.bankTarget.length-1; i++){
                    this.transferTarget.options[i].disabled = false
                    console.log("Wallet Gaya")
                }
                this.classTarget.lastElementChild.value = "BankAccount"  
            }
            else{
                for(var i = 0; i < this.bankTarget.length-1; i++){
                    this.transferTarget.options[i].disabled = true
                }
                this.classTarget.lastElementChild.value = "Wallet"
                this.transferTarget.options[this.bankTarget.length-1].disabled = false

            }

        }
        else
            this.classTarget.classList.add("hidden")
        console.log(this.transferTarget.value)
        
    }

    
}
