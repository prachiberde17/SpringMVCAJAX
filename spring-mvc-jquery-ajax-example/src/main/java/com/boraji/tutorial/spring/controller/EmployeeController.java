package com.boraji.tutorial.spring.controller;

import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boraji.tutorial.spring.model.Employee;
import com.boraji.tutorial.spring.model.EmployeeJsonRespone;

/**
 * @author imssbora
 */
@Controller
public class EmployeeController {

   @GetMapping("/")
   public String employeeForm() {
      return "employeeForm";
   }

   @PostMapping(value = "/saveEmployee", produces = { MediaType.APPLICATION_JSON_VALUE })
   @ResponseBody
   public EmployeeJsonRespone saveEmployee(@ModelAttribute @Valid Employee employee,
         BindingResult result) {

      EmployeeJsonRespone respone = new EmployeeJsonRespone();
      
      if(result.hasErrors()){
         
         //Get error message
         Map<String, String> errors = result.getFieldErrors().stream()
               .collect(
                     Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage)
                 );
         
         respone.setValidated(false);
         respone.setErrorMessages(errors);
      }else{
         // Implement business logic to save employee into database
         //..
         respone.setValidated(true);
         respone.setEmployee(employee);
      }
      return respone;
   }
}
