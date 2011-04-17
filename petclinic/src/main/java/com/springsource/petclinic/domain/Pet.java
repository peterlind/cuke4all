package com.springsource.petclinic.domain;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.validation.constraints.Min;
import com.springsource.petclinic.domain.Owner;
import javax.persistence.ManyToOne;
import com.springsource.petclinic.reference.PetType;
import javax.persistence.Enumerated;

@RooJavaBean
@RooToString
@RooEntity(finders = { "findPetsByNameAndWeight", "findPetsByOwner", "findPetsBySendRemindersAndWeightLessThan" })
public class Pet {

    @NotNull
    private boolean sendReminders;

    @NotNull
    @Size(min = 1)
    private String name;

    @NotNull
    @Min(0L)
    private Float weight;

    @ManyToOne
    private Owner owner;

    @NotNull
    @Enumerated
    private PetType sort;
}
