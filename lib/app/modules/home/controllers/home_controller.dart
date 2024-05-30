import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var sortingTechnique = [
    'Bubble Sort',
    'Cocktail Sort',
    'Heap Sort',
    'Insertion Sort',
    'Linear Sort',
    'Merge Sort',
    'Quick Sort',
    'Selection Sort',
  ].obs;

  var speed = ['Fast', 'Normal', 'Slow'].obs;

  var array = <double>[].obs;
  var sortedIndices = <int>[].obs;

  var selectedTechnique = 'Bubble Sort'.obs;
  var selectedSpeed = 'Normal'.obs;

  var isCheckingIndex = Rx<int?>(null);

  var isSorting = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void setSelectedTechnique(String value) {
    selectedTechnique.value = value;
  }

  void setSelectedSpeed(String value) {
    selectedSpeed.value = value;
  }

  void addRandomValues() {
    array.clear();
    sortedIndices.clear();
    isCheckingIndex.value = null;
    Random random = Random();
    for (int i = 0; i < 20; i++) {
      int randomValue = 80 + random.nextInt(721); // Generate integer values between 80 and 800
      array.add(randomValue.toDouble()); // Convert to double to maintain type consistency
    }
  }


  Future<void> bubbleSort() async {
    int n = array.length;
    int delay = _getDelay();
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        isCheckingIndex.value = j;
        await Future.delayed(Duration(milliseconds: delay));
        if (array[j] > array[j + 1]) {
          // Swap
          double temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
          await Future.delayed(Duration(milliseconds: delay));
        }
      }
      // Mark the sorted element
      sortedIndices.add(n - i - 1);
    }
    // Mark the first element as sorted
    sortedIndices.add(0);
    isCheckingIndex.value = null;
  }

  Future<void> cocktailSort() async {
    int n = array.length;
    int delay = _getDelay();
    bool swapped = true;
    int start = 0;
    int end = n - 1;

    while (swapped) {
      swapped = false;
      for (int i = start; i < end; ++i) {
        isCheckingIndex.value = i;
        await Future.delayed(Duration(milliseconds: delay));
        if (array[i] > array[i + 1]) {
          double temp = array[i];
          array[i] = array[i + 1];
          array[i + 1] = temp;
          swapped = true;
          await Future.delayed(Duration(milliseconds: delay));
        }
      }
      if (!swapped) break;
      swapped = false;
      end--;
      for (int i = end - 1; i >= start; --i) {
        isCheckingIndex.value = i;
        await Future.delayed(Duration(milliseconds: delay));
        if (array[i] > array[i + 1]) {
          double temp = array[i];
          array[i] = array[i + 1];
          array[i + 1] = temp;
          swapped = true;
          await Future.delayed(Duration(milliseconds: delay));
        }
      }
      start++;
    }
    isCheckingIndex.value = null;
  }

  Future<void> heapSort() async {
    isSorting.value = true;

    int n = array.length;
    int delay = _getDelay();

    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      await _heapify(n, i, delay);
    }

    for (int i = n - 1; i >= 0; i--) {
      double temp = array[0];
      array[0] = array[i];
      array[i] = temp;

      await _heapify(i, 0, delay);
      await Future.delayed(Duration(milliseconds: delay));
      sortedIndices.add(i); // Add the sorted index after each iteration
    }

    isCheckingIndex.value = null; // Reset isCheckingIndex after sorting
    isSorting.value = false;
  }

  Future<void> _heapify(int n, int i, int delay) async {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < n && array[left] > array[largest]) {
      largest = left;
    }

    if (right < n && array[right] > array[largest]) {
      largest = right;
    }

    if (largest != i) {
      double temp = array[i];
      array[i] = array[largest];
      array[largest] = temp;

      await _heapify(n, largest, delay);
    }

    isCheckingIndex.value = i; // Update isCheckingIndex after each comparison
  }



  Future<void> insertionSort() async {
  int n = array.length;
    int delay = _getDelay();
    for (int i = 1; i < n; ++i) {
      double key = array[i];
      int j = i - 1;

      while (j >= 0 && array[j] > key) {
        isCheckingIndex.value = j;
        await Future.delayed(Duration(milliseconds: delay));
        array[j + 1] = array[j];
        j = j - 1;
      }
      array[j + 1] = key;
      sortedIndices.add(i);
      await Future.delayed(Duration(milliseconds: delay));
    }

    isCheckingIndex.value = null;
  }

  Future<void> linearSort() async {
    int n = array.length;
    int delay = _getDelay();

    for (int i = 0; i < n - 1; i++) {
      for (int j = i + 1; j < n; j++) {
        isCheckingIndex.value = j;
        await Future.delayed(Duration(milliseconds: delay));
        if (array[i] > array[j]) {
          double temp = array[i];
          array[i] = array[j];
          array[j] = temp;
          await Future.delayed(Duration(milliseconds: delay));
        }
      }
      sortedIndices.add(i);
    }
    isCheckingIndex.value = null;
  }

  Future<void> mergeSort() async {
    isSorting.value = true;
    int delay = _getDelay();

    await _mergeSortHelper(0, array.length - 1, delay);

    isCheckingIndex.value = null;
    isSorting.value = false;
  }

  Future<void> _mergeSortHelper(int left, int right, int delay) async {
    if (left < right) {
      int mid = (left + right) ~/ 2;

      await _mergeSortHelper(left, mid, delay);
      await _mergeSortHelper(mid + 1, right, delay);

      await _merge(left, mid, right, delay);
    }
  }

  Future<void> _merge(int left, int mid, int right, int delay) async {
    List<double> tempArray = List<double>.filled(right - left + 1, 0);
    int i = left;
    int j = mid + 1;
    int k = 0;

    while (i <= mid && j <= right) {
      if (array[i] <= array[j]) {
        tempArray[k++] = array[i++];
      } else {
        tempArray[k++] = array[j++];
      }
    }

    while (i <= mid) {
      tempArray[k++] = array[i++];
    }

    while (j <= right) {
      tempArray[k++] = array[j++];
    }

    for (int p = 0; p < k; p++) {
      isCheckingIndex.value = left + p;
      array[left + p] = tempArray[p];
      await Future.delayed(Duration(milliseconds: delay));
    }
  }

  Future<void> quickSort() async {
    int delay = _getDelay();

    await _quickSortHelper(0, array.length - 1, delay);

    isCheckingIndex.value = null;
  }

  Future<void> _quickSortHelper(int low, int high, int delay) async {
    if (low < high) {
      int pi = await _partition(low, high, delay);

      await _quickSortHelper(low, pi - 1, delay);
      await _quickSortHelper(pi + 1, high, delay);
    }
  }

  Future<int> _partition(int low, int high, int delay) async {
    double pivot = array[high];
    int i = low - 1;

    for (int j = low; j <= high - 1; j++) {
      isCheckingIndex.value = j;
      await Future.delayed(Duration(milliseconds: delay));
      if (array[j] < pivot) {
        i++;
        double temp = array[i];
        array[i] = array[j];
        array[j] = temp;
        await Future.delayed(Duration(milliseconds: delay));
      }
    }

    double temp = array[i + 1];
    array[i + 1] = array[high];
    array[high] = temp;

    return i + 1;
  }

  Future<void> selectionSort() async {
    int delay = _getDelay();

    int n = array.length;

    for (int i = 0; i < n - 1; i++) {
      int minIndex = i;

      for (int j = i + 1; j < n; j++) {
        isCheckingIndex.value = j;
        await Future.delayed(Duration(milliseconds: delay));
        if (array[j] < array[minIndex]) {
          minIndex = j;
        }
      }

      double temp = array[minIndex];
      array[minIndex] = array[i];
      array[i] = temp;
      await Future.delayed(Duration(milliseconds: delay));
      sortedIndices.add(i);
    }

    isCheckingIndex.value = null;
  }

  void onSortClick() {
    switch (selectedTechnique.value) {
      case 'Bubble Sort':
        bubbleSort();
        break;
      case 'Cocktail Sort':
        cocktailSort();
        break;
      case 'Heap Sort':
        heapSort();
        break;
      case 'Insertion Sort':
        insertionSort();
        break;
      case 'Linear Sort':
        linearSort();
        break;
      case 'Merge Sort':
        mergeSort();
        break;
      case 'Quick Sort':
        quickSort();
        break;
      case 'Selection Sort':
        selectionSort();
        break;
      default:
        print('Unknown sorting technique');
    }
  }


  int _getDelay() {
    switch (selectedSpeed.value) {
      case 'Fast':
        return 100;
      case 'Slow':
        return 500;
      default:
        return 300;
    }
  }
}
