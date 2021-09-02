import { TimeScale } from "chart.js";
import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["table","amount","amountHead","expense","button","percent"]
    initialize(){
        this.iter = 0
        this.amountTargets.forEach(element => {element.children[0].disabled = true; element.children[0].value = 0;})
        this.sum = 0.0
        this.count = 0;
        console.log("Iam Connected")
        
    }
    changeFirst(event){
        this.amountTargets[event.target.dataset.index].children[0].disabled = false;
        this.amountTargets[event.target.dataset.index].children[0].value = this.expenseTarget.value;
        this.handleSubmit()
    }
    hideTable(event){
        //console.log(event.target.dataset.size)
        console.log(this.amountTargets)
        if(this.tableTarget.checked){
            this.amountTargets.forEach(element => element.children[0].disabled = true)
            this.percentTarget.children[0].disabled = true
            this.tableTarget.disabled = false
            this.amountHeadTargets.forEach(element => {
                console.log(element.children[0].checked)
                if(element.children[0].checked){
                    this.amountTargets[this.iter].children[0].value = this.expenseTarget.value/this.count
                }
                else{
                    this.amountTargets[this.iter].children[0].value = 0
                }
                this.iter++
            }
            )
            
        }
        else{
            this.percentTarget.children[0].disabled = false
            if(this.percentTarget.children[0].children[0].children[1].checked)
                this.tableTarget.disabled = true
            else
                this.tableTarget.disabled = false
        }
        
       
        
    }
    hideAmount(event){
        event.preventDefault()
        if(!this.tableTarget.checked){
            this.count=0
            this.amountHeadTargets.forEach(element => {
                console.log(element.children[0].checked)
                if(element.children[0].checked){
                    this.amountTargets[this.count].children[0].disabled = false
                    this.amountTargets[this.count].children[0].value = 0
                    this.buttonTarget.children[0].disabled = true
                }
                else{
                    this.amountTargets[this.count].children[0].disabled = true
 
                }
                this.count++
            }
            )
        }
        else{
            this.count=0
            this.iter = 0
            this.amountHeadTargets.forEach(element => {
                console.log(element.children[0].checked)
                if(element.children[0].checked){
                    //this.amountTargets.children[this.count].disabled = false
                    console.log(this.count)

                    this.count++
                }
                else{
                    //this.amountTargets.children[this.count].disabled = true
                }
            }
            )
            
            this.amountHeadTargets.forEach(element => {
                console.log(element.children[0].checked)
                if(element.children[0].checked){
                    this.amountTargets[this.iter].children[0].value = this.expenseTarget.value/this.count
                }
                else{
                    this.amountTargets[this.iter].children[0].value = 0
                }
                this.iter++
            }
            )
             
        }
    }
    handleSubmit(){
        this.amountTargets.forEach(element => {this.sum += Number.parseFloat(element.children[0].value); console.log(element.children[0].value)})
       
        console.log(this.buttonTarget.children[0])
        if(this.percentTarget.children[0].children[0].children[1].checked){

            if(this.sum < 100 || this.sum > 100){
                console.log(this.buttonTarget.children[0])
                this.buttonTarget.children[0].disabled = true
               
            }
            else{
                this.buttonTarget.children[0].disabled = false
            }
        }
        else{
            if(this.sum < this.expenseTarget.value || this.sum > this.expenseTarget.value){
                console.log(this.buttonTarget.children[0])
                this.buttonTarget.children[0].disabled = true
               
            }
            else{
                this.buttonTarget.children[0].disabled = false
            }

        }
        console.log(this.sum) 
        this.sum = 0
    }
    handle(){
        console.log(this.sum)
        this.amountHeadTargets.forEach(element => element.children[0].disabled = false)
        this.amountTargets.forEach(e => e.children[0].disabled = false)
        this.handleSubmit()
 
    }
}