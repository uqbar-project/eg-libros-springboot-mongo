package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.UserException
import ar.edu.unsam.libros.dao.LibroRepository
import ar.edu.unsam.libros.dao.PrestamoRepository
import ar.edu.unsam.libros.domain.Prestamo
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*")
class PrestamoController {
	
	@Autowired
	PrestamoRepository prestamoRepository
	
	@Autowired
	LibroRepository libroRepository
	
	@GetMapping(value = "/prestamos")
	def getPrestamos() {
		this.prestamoRepository.getPrestamosPendientes
	}
  
	@PostMapping("/prestamos")
	def prestar(@RequestBody Prestamo prestamo) {
		try {
			val libro = libroRepository.findById(prestamo.libro.id).orElseThrow([ new UserException("El libro con id " + prestamo.libro.id + " no existe" )])
			prestamo.libro = libro
			prestamo.validar
			prestamoRepository.save(prestamo)
			libro.prestar
			libroRepository.save(libro)
			ResponseEntity.ok.body("Se generó el préstamo correctamente")
		} catch (UserException e) {
			ResponseEntity.badRequest.body(e.message)
		}
	}
  
//	@PutMapping(value="/zonas/{id}")
//  def getZona(@PathVariable Long id) {
//  	mapper.registerModule(
//			new SimpleModule().addSerializer(new ZonaParaGrillaSerializer)
//		)
//  	
//  	this
//  		.zonaRepository
//  		.findById(id)
//  		.map([ zona |	
//  			mapper.writeValueAsString(zona)
//  		])
//  		.orElseThrow([ 
//  			 throw new ResponseStatusException(HttpStatus.NOT_FOUND, "La zona con identificador " + id + " no existe") 
//  		])
//  }
//
	static def mapper() {
		new ObjectMapper => [
			configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
			configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false)
			configure(SerializationFeature.INDENT_OUTPUT, true)
		]
	}
}