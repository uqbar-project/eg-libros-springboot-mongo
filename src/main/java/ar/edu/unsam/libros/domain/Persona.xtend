package ar.edu.unsam.libros.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document

@Accessors
@Document(collection = "personas")
class Persona {
	@Id String id
	String nombre
	String password
		
	override toString() {
		nombre
	}
	
}