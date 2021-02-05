package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.dao.PrestamoRepository
import com.fasterxml.jackson.databind.DeserializationFeature
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*", methods= #[RequestMethod.GET])
class PrestamoController {
	
	@Autowired
	PrestamoRepository prestamoRepository
	
	@GetMapping(value = "/prestamos")
	def getPrestamos() {
		this.prestamoRepository.getPrestamosPendientes
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