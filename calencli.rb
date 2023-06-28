require "date"
require "colorize"

# Datos
id = 0
events = [
  { "id" => (id = id.next),
    "start_date" => "2023-02-13T00:00:00-05:00",
    "title" => "Ruby Basics 1",
    "end_date" => "",
    "notes" => "Ruby Basics 1 notes",
    "guests" => ["Paulo", "Andre"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-13T09:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2023-02-13T10:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-14T00:00:00-05:00",
    "title" => "Ruby Basics 2",
    "end_date" => "",
    "notes" => "Ruby Basics 2 notes",
    "guests" => ["Paulo", "Andre"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-14T12:00:00-05:00",
    "title" => "Soft Skills - Mindsets",
    "end_date" => "2023-02-14T13:30:00-05:00",
    "notes" => "Some extra notes",
    "guests" => ["Mili"],
    "calendar" => "soft-skills" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-15T00:00:00-05:00",
    "title" => "Ruby Methods",
    "end_date" => "",
    "notes" => "Ruby Methods notes",
    "guests" => ["Paulo", "Andre"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-15T09:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2023-02-15T10:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-16T09:00:00-05:00",
    "title" => "Summary Workshop",
    "end_date" => "2023-02-16T13:30:00-05:00",
    "notes" => "A lot of notes",
    "guests" => ["Paulo", "Andre", "Diego"],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-16T00:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-17T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-17T09:00:00-05:00",
    "title" => "English Course",
    "end_date" => "2023-02-17T10:30:00-05:00",
    "notes" => "English notes",
    "guests" => ["Stephanie"],
    "calendar" => "english" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-18T10:00:00-05:00",
    "title" => "Breakfast with my family",
    "end_date" => "2023-02-18T11:00:00-05:00",
    "notes" => "",
    "guests" => [],
    "calendar" => "default" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-18T15:00:00-05:00",
    "title" => "Study",
    "end_date" => "2023-02-18T20:00:00-05:00",
    "notes" => "",
    "guests" => [],
    "calendar" => "default" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-23T00:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" },
  { "id" => (id = id.next),
    "start_date" => "2023-02-24T09:00:00-05:00",
    "title" => "Extended Project",
    "end_date" => "",
    "notes" => "",
    "guests" => [],
    "calendar" => "web-dev" }
]

# Obtiene la fecha actual
current_date = Date.today # Date.new(2021, 11, 15)

#  Hash que mapea los nombres de los calendarios a colores que podemos usar en la gema colorize.
CALENDAR_COLORS = {
  "web-dev" => :light_red,
  "english" => :light_magenta,
  "soft-skills" => :green
}

# Metodos

# Obtiene el lunes correspondiente a una fecha dada
def get_monday(current)
  Date.commercial(current.year, current.cweek)
end

# Imprime un evento en formato de línea
def print_event(event, day = nil)
  # Obtiene el color correspondiente al calendario del evento
  color = event ? CALENDAR_COLORS[event["calendar"]] || :default : nil
  print day ? day.strftime("%a %b %d").ljust(12) : "".ljust(12)

  if !event || event["end_date"].empty?
    print("".ljust(14))
  else
    start = DateTime.parse(event["start_date"])
    finish = DateTime.parse(event["end_date"])
    # Imprime el intervalo de tiempo del evento en formato HH:MM - HH:MM
    print("#{start.strftime('%H:%M')} - #{finish.strftime('%H:%M')}".ljust(14).colorize(color))
  end

  # Imprime el título y el ID del evento con el color correspondiente
  # en caso de no existir imprime No events
  puts event ? "#{event['title']} (#{event['id']})".colorize(color) : "No events"
end

# Imprime los eventos de un día pasado por parametro
def print_day(day, events)
  sorted = events.sort_by { |event| event["start_date"] }
  first = sorted.shift

  print_event(first, day)

  sorted.each do |event|
    print_event(event)
  end

  puts ""
end

# Imprime la lista de eventos de una semana
def print_list(current_date, events)
  # Imprime el encabezado
  puts "Welcome to CalenCLI".center(78, "-")
  puts ""

  current = get_monday(current_date)
  loop do
    day_events = events.filter { |event| Date.parse(event["start_date"]) == current }
    print_day(current, day_events)

    break if current.sunday?

    current += 1
  end
end

# Imprime el menú de opciones
def print_menu
  puts "-" * 78
  puts "list | create | show | update | delete | next | prev | exit"
end

# Obtiene una cadena de texto del usuario, con opción de requerir que no esté vacía
def get_string(prompt, required: false, error_message: "Cannot be blank")
  string = ""

  loop do
    print prompt
    string = gets.chomp
    required && string.empty? ? puts(error_message) : break
  end

  string
end

# Solicita al usuario que ingrese la hora de inicio y fin de un evento
def ask_start_end
  loop do
    start_end = get_string("start_end: ")
    break if start_end.empty?

    hours = start_end.split

    unless hours.size == 2
      puts "Format: 'HH:MM HH:MM' or leave it empty"
      next
    end

    unless DateTime.parse(hours[0]) < DateTime.parse(hours[1])
      puts "Cannot end before start"
      next
    end

    return hours
  end
end

# Solicita al usuario que ingrese los detalles de un nuevo evento
def event_form
  date = get_string("date: ", required: true, error_message: "Type a valid date: YYYY-MM-DD")
  title = get_string("title: ", required: true)
  calendar = get_string("calendar: ")
  hours = ask_start_end
  start_date = DateTime.parse(date)
  end_date = ""
  if hours
    start_time = DateTime.parse(hours[0])
    end_time = DateTime.parse(hours[1])
    start_date = DateTime.parse(date) + (start_time.hour / 24.0) + (start_time.min / (24.0 * 60.0))
    end_date = DateTime.parse(date) + (end_time.hour / 24.0) + (end_time.min / (24.0 * 60.0))
  end

  notes = get_string("notes: ")
  guests = get_string("guests: ").split(",")

  {
    "start_date" => start_date.to_s,
    "title" => title,
    "end_date" => end_date.to_s,
    "notes" => notes,
    "guests" => guests,
    "calendar" => calendar
  }
end

# Obtiene un evento existente por su ID
def get_event(events)
  event_id = get_string("id: ", required: true, error_message: "Cannot be blank")
  event = events.find { |ev| ev["id"] == event_id.to_i }

  unless event
    puts "Event not found"
    return
  end

  event
end

# Muestra los detalles de un evento
def show_event(event)
  start_date = DateTime.parse(event["start_date"])
  end_date = !event["end_date"].empty? && DateTime.parse(event["end_date"])
  start_end = end_date ? "#{start_date.strftime('%H:%M')} #{end_date.strftime('%H:%M')}" : ""

  puts "date: #{start_date.strftime('%F')}"
  puts "title: #{event['title']}"
  puts "calendar: #{event['calendar']}"
  puts "start_end: #{start_end}"
  puts "notes: #{event['notes']}"
  puts "guests: #{event['guests'].join(',')}"
end

# Main program

action = nil
print_list(current_date, events)

# bucle principal que solicita al usuario una acción a realizar.
# El bucle se ejecuta hasta que el usuario ingrese "exit" como acción.
while action != "exit"
  print_menu
  print "action: "
  action = gets.chomp

  case action
  when "list"
    print_list(current_date, events)
  when "create"
    new_event = event_form
    new_event["id"] = (id = id.next)
    events.push(new_event)
  when "show"
    event = get_event(events)
    show_event(event)
  when "update"
    event = get_event(events)
    data = event_form
    event.merge!(data)
  when "delete"
    event = get_event(events)
    events.delete(event)
  when "next"
    current_date += 7
    print_list(current_date, events)
  when "prev"
    current_date -= 7
    print_list(current_date, events)
  when "exit"
    puts "Thanks for using calenCLI"
  else
    puts "Invalid action"
  end
end
