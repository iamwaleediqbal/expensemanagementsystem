import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["add","select"]
    addfield(){
        this.addTarget.classList.remove("hidden");
    //     var txtNewInputBox = document.createElement('div');
    // // Then add the content (a new input box) of the element.
	//     txtNewInputBox.innerHTML = "<input type='text' id='newInputBox'>";
    // // Finally put it where it is supposed to appear.
	//     document.getElementById("newElementId").appendChild(txtNewInputBox);
    }
    hidefield(){
        this.addTarget.classList.add("hidden");
        location.reload()
    }
    selection(event){
        event.preventDefault()
        console.log("Yahan")
        if(this.selectTarget.classList.includes("hidden"))
            this.selectTarget.classList.remove("hidden")
        else
            this.selectTarget.classList.add("hidden")
    }
}