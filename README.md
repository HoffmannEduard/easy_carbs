# EasyCarbs

EasyCarbs ist eine Flutter-basierte Anwendung zur Unterstützung von Menschen mit Diabetes bei der Verwaltung ihrer Mahlzeiten und der Berechnung benötigter Insulineinheiten.

Die App ermöglicht die Erfassung von Mahlzeiten inklusive Nährwertangaben und berechnet daraus:

- BE (Broteinheiten) bzw. KE (Kohlenhydrateinheiten)
- FPE (Fett-Protein-Einheiten)
- zeitabhängige Insulineinheiten basierend auf individuellen Insulinfaktoren

---

## Fachlicher Hintergrund

### BE / KE
- 1 BE = 12g Kohlenhydrate
- 1 KE = 10g Kohlenhydrate
- Die Einheit ist benutzerabhängig konfigurierbar

### FPE
Die FPE wird aus Fett- und Proteinanteilen berechnet:

FPE = (Fett * 9 kcal + Protein * 4 kcal) / 100

### Zeitabhängige Insulinfaktoren
Der Insulinfaktor ist in vier Zeitblöcke unterteilt:
- Morgen
- Mittag
- Abend
- Nacht

Abhängig von der aktuellen Uhrzeit wird automatisch der passende Faktor zur Berechnung der Insulineinheiten verwendet.

---

## Kernfunktionen

- Erstellen und Verwalten von Mahlzeiten
- Automatische oder manuelle Berechnung von BE/KE und FPE
- Zeitabhängige Insulinberechnung
- Persistente Speicherung mit Drift
- Benutzerkonfiguration der Insulinfaktoren
- Aktivierbare Anzeige von Insulineinheiten

---

## Architektur

Die Anwendung folgt einer klar getrennten Layered Architecture:

### Domain Layer
Enthält:
- Entitäten (Meal, Nutrition, UserSettings)
- Fachlogik (Berechnungen, Resolver, UseCases)

### Data Layer
- Drift-Datenbank
- DAOs
- Repository-Implementierungen

### Presentation Layer
- Flutter Widgets
- Riverpod State Management


---

## Technologie-Stack

- Flutter (UI)
- Riverpod (State Management)
- Drift (lokale SQL-Datenbank)

---

## Teststrategie

Die Anwendung ist abgesichert durch:

- Unit Tests (Berechnungen und Services)
- Repository Tests 
- Widget Tests 
- Integration Test (End-to-End Flow)

---

## Projektstruktur

lib/
- data/
- domain/
- presentation

test/
integration_test/