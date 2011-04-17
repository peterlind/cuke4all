// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.springsource.petclinic.web;

import com.springsource.petclinic.domain.Owner;
import com.springsource.petclinic.domain.Pet;
import java.io.UnsupportedEncodingException;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect OwnerController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST)
    public String OwnerController.create(@Valid Owner owner, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("owner", owner);
            addDateTimeFormatPatterns(uiModel);
            return "owners/create";
        }
        uiModel.asMap().clear();
        owner.persist();
        return "redirect:/owners/" + encodeUrlPathSegment(owner.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String OwnerController.createForm(Model uiModel) {
        uiModel.addAttribute("owner", new Owner());
        addDateTimeFormatPatterns(uiModel);
        return "owners/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String OwnerController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("owner", Owner.findOwner(id));
        uiModel.addAttribute("itemId", id);
        return "owners/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String OwnerController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            uiModel.addAttribute("owners", Owner.findOwnerEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Owner.countOwners() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("owners", Owner.findAllOwners());
        }
        addDateTimeFormatPatterns(uiModel);
        return "owners/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String OwnerController.update(@Valid Owner owner, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("owner", owner);
            addDateTimeFormatPatterns(uiModel);
            return "owners/update";
        }
        uiModel.asMap().clear();
        owner.merge();
        return "redirect:/owners/" + encodeUrlPathSegment(owner.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String OwnerController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("owner", Owner.findOwner(id));
        addDateTimeFormatPatterns(uiModel);
        return "owners/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String OwnerController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Owner.findOwner(id).remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/owners";
    }
    
    @ModelAttribute("owners")
    public Collection<Owner> OwnerController.populateOwners() {
        return Owner.findAllOwners();
    }
    
    @ModelAttribute("pets")
    public java.util.Collection<Pet> OwnerController.populatePets() {
        return Pet.findAllPets();
    }
    
    void OwnerController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("owner_birthday_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    String OwnerController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
