# Crear las familias
family_moises = Family.create(name: 'Moises Family')

# Crear las personas
moises = Person.create(name: 'Moisés', family: family_moises)
marta = Person.create(name: 'Marta', family: family_moises)

# Hijos de Moisés y Marta
roberto = Person.create(name: 'Roberto', family: family_moises)
ana = Person.create(name: 'Ana', family: family_moises)
luis = Person.create(name: 'Luis', family: family_moises)

# Parejas de los hijos
laura = Person.create(name: 'Laura', family: family_moises)
carlos = Person.create(name: 'Carlos', family: family_moises)
julia = Person.create(name: 'Julia', family: family_moises)

# Hijos de Roberto y Laura
clara = Person.create(name: 'Clara', family: family_moises)
pedro = Person.create(name: 'Pedro', family: family_moises)

# Hijos de Ana y Carlos
sofia = Person.create(name: 'Sofía', family: family_moises)
diego = Person.create(name: 'Diego', family: family_moises)

# Hija de Luis y Julia
laura_hija = Person.create(name: 'Karen', family: family_moises)

# Relaciones de padres e hijos
Relationship.create(person: moises, linked_person: roberto, relationship_type: 'parent')
Relationship.create(person: moises, linked_person: ana, relationship_type: 'parent')
Relationship.create(person: moises, linked_person: luis, relationship_type: 'parent')
Relationship.create(person: marta, linked_person: roberto, relationship_type: 'parent')
Relationship.create(person: marta, linked_person: ana, relationship_type: 'parent')
Relationship.create(person: marta, linked_person: luis, relationship_type: 'parent')

# Relaciones de hermanos
Relationship.create(person: roberto, linked_person: ana, relationship_type: 'sibling')
Relationship.create(person: roberto, linked_person: luis, relationship_type: 'sibling')
Relationship.create(person: ana, linked_person: luis, relationship_type: 'sibling')

# Parejas
Relationship.create(person: roberto, linked_person: laura, relationship_type: 'spouse')
Relationship.create(person: ana, linked_person: carlos, relationship_type: 'spouse')
Relationship.create(person: luis, linked_person: julia, relationship_type: 'spouse')

# Hijos de Roberto y Laura
Relationship.create(person: roberto, linked_person: clara, relationship_type: 'parent')
Relationship.create(person: roberto, linked_person: pedro, relationship_type: 'parent')
Relationship.create(person: laura, linked_person: clara, relationship_type: 'parent')
Relationship.create(person: laura, linked_person: pedro, relationship_type: 'parent')

# Hijos de Ana y Carlos
Relationship.create(person: ana, linked_person: sofia, relationship_type: 'parent')
Relationship.create(person: ana, linked_person: diego, relationship_type: 'parent')
Relationship.create(person: carlos, linked_person: sofia, relationship_type: 'parent')
Relationship.create(person: carlos, linked_person: diego, relationship_type: 'parent')

# Hija de Luis y Julia
Relationship.create(person: luis, linked_person: laura_hija, relationship_type: 'parent')
Relationship.create(person: julia, linked_person: laura_hija, relationship_type: 'parent')
