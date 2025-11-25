# Riverpod

## Provider
Provider und Consumer 
für einfache Daten, Listen, Sets

Stateless -> ConsumerWidget(BuildContext und WidgetRef) und ref.watch(Provider) um darauf zuzugreifen.

Statefull -> ConsumerStatefullWidget 

## Notifier
Ermöglicht State-Management
Beispiel: 

Class CartNotifier extends Notifier<Set<Product>> {
    //inital value
    @override
    build() {...}

    //methods to upstate state
}

Provider erstellen: 
final cartNotifierProvider = NotifierProvider<CartNotifier, <Set<Product>>(() {
...
});


## Architektur
UI → Provider → UseCase → Entity / Repository → DB