// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.springsource.petclinic.web;

import com.springsource.petclinic.domain.Pet;
import com.springsource.petclinic.domain.Vet;
import com.springsource.petclinic.domain.Visit;
import java.io.UnsupportedEncodingException;
import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
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

privileged aspect VisitController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST)
    public String VisitController.create(@Valid Visit visit, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("visit", visit);
            addDateTimeFormatPatterns(uiModel);
            return "visits/create";
        }
        uiModel.asMap().clear();
        visit.persist();
        return "redirect:/visits/" + encodeUrlPathSegment(visit.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String VisitController.createForm(Model uiModel) {
        uiModel.addAttribute("visit", new Visit());
        addDateTimeFormatPatterns(uiModel);
        List dependencies = new ArrayList();
        if (Pet.countPets() == 0) {
            dependencies.add(new String[]{"pet", "pets"});
        }
        uiModel.addAttribute("dependencies", dependencies);
        return "visits/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String VisitController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("visit", Visit.findVisit(id));
        uiModel.addAttribute("itemId", id);
        return "visits/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String VisitController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            uiModel.addAttribute("visits", Visit.findVisitEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Visit.countVisits() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("visits", Visit.findAllVisits());
        }
        addDateTimeFormatPatterns(uiModel);
        return "visits/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String VisitController.update(@Valid Visit visit, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            uiModel.addAttribute("visit", visit);
            addDateTimeFormatPatterns(uiModel);
            return "visits/update";
        }
        uiModel.asMap().clear();
        visit.merge();
        return "redirect:/visits/" + encodeUrlPathSegment(visit.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String VisitController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("visit", Visit.findVisit(id));
        addDateTimeFormatPatterns(uiModel);
        return "visits/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String VisitController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Visit.findVisit(id).remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/visits";
    }
    
    @ModelAttribute("pets")
    public Collection<Pet> VisitController.populatePets() {
        return Pet.findAllPets();
    }
    
    @ModelAttribute("vets")
    public java.util.Collection<Vet> VisitController.populateVets() {
        return Vet.findAllVets();
    }
    
    @ModelAttribute("visits")
    public java.util.Collection<Visit> VisitController.populateVisits() {
        return Visit.findAllVisits();
    }
    
    void VisitController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("visit_maxvisitdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("visit_minvisitdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("visit_visitdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    String VisitController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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
