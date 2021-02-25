package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.dao.PersonaRepository
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*")
class PersonaController {

	@Autowired
	PersonaRepository personaRepository

	@GetMapping("/personas")
	@ApiOperation("Devuelve las personas que son socios de la biblioteca y pueden pedir prestado un libro.")
	def getLibrosPrestables() {
		this.personaRepository.findAll
	}

}
