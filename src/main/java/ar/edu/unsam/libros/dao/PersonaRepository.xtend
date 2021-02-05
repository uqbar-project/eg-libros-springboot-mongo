package ar.edu.unsam.libros.dao

import ar.edu.unsam.libros.domain.Persona
import org.springframework.data.mongodb.repository.MongoRepository

interface PersonaRepository extends MongoRepository<Persona, Long> {
	
	def Persona findByNombre(String nombre)

}
