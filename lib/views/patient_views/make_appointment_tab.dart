import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randevu_al/controllers/patient_controller.dart';
import 'package:randevu_al/core/theme/colors.style.dart';
import 'package:randevu_al/models/appointment_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:randevu_al/core/utilities/extensions.dart';

class MakeAppointmentTab extends StatefulWidget {
  const MakeAppointmentTab({super.key});

  @override
  State<MakeAppointmentTab> createState() => _MakeAppointmentTabState();
}

class _MakeAppointmentTabState extends State<MakeAppointmentTab> {
  late final patientController = Get.find<PatientController>();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildStepper(),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Stepper(
      key: const Key("Stepper1"),
      controlsBuilder: (context, details) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(currentStep == 4 ? "Randevu Al" : 'İleri'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: details.onStepCancel,
                child: const Text('Geri'),
              ),
            ],
          ),
        );
      },
      currentStep: currentStep,
      onStepContinue: () {
        if (currentStep == 4) {
          if (patientController.selectedDate == null) {
            Get.rawSnackbar(
              message: "Lütfen bir tarih seçiniz",
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }

          Get.defaultDialog(
            title: "Randevu Onayla",
            content:
                Text(patientController.selectedDate?.toIso8601String() ?? ""),
            textConfirm: "Onayla",
            textCancel: "İptal",
            buttonColor: IColors.primary,
            confirmTextColor: Colors.white,
            cancelTextColor: IColors.primary,
            onConfirm: () async {
              await patientController.confirmAppointment().then((value) {
                if (value != null) {
                  Get.context?.showSuccessSnackBar(
                    message: "Randevu alındı",
                  );
                  Get.back();

                  setState(() {
                    currentStep = 0;
                  });
                }
              });
            },
          );
        }

        if (currentStep < 4) {
          setState(() {
            currentStep = currentStep + 1;
          });
        }
      },
      onStepCancel: () {
        if (currentStep > 0) {
          if (currentStep == 3) {
            patientController.selectedDoctorId.value = null;
          }

          if (currentStep == 2) {
            patientController.selectedBranchId.value = null;
          }

          if (currentStep == 1) {
            patientController.selectedHospitalId.value = null;
          }

          setState(() {
            currentStep = currentStep - 1;
          });
        }
      },
      steps: [
        Step(
          title: const Text('Şehir Seçimi'),
          content: _buildSelectCityContainer(),
          isActive: currentStep == 0,
        ),
        Step(
          title: const Text('Hastane Seçimi'),
          content: _buildSelectHospitalContainer(),
          isActive: currentStep == 1,
        ),
        Step(
          title: const Text('Bölüm Seçimi'),
          content: _buildSelectBranchContainer(),
          isActive: currentStep == 2,
        ),
        Step(
          title: const Text('Doktor Seçimi'),
          content: _buildSelectDoctorContainer(),
          isActive: currentStep == 3,
        ),
        Step(
          title: const Text('Tarih Seçimi'),
          content: _buildSelectedDoctorAvailabilityContainer(),
          isActive: currentStep == 4,
        ),
      ],
    );
  }

  Widget _buildSelectCityContainer() {
    return Obx(
      () => DropdownButton(
        value: patientController.selectedCityId.value,
        isExpanded: true,
        isDense: true,
        hint: const Text("Şehir Seçiniz"),
        items: patientController.cities
            .map((element) => DropdownMenuItem(
                  value: element.cityId,
                  child: Text(element.name ?? "Şehir Adı Yok"),
                ))
            .toList(),
        onChanged: (cityId) {
          patientController.selectedCityId.value = cityId;
        },
      ),
    );
  }

  Widget _buildSelectHospitalContainer() {
    return Obx(() {
      if (patientController.selectedCityId.value == null) {
        return const Text("Önce Şehir Seçimi Yapın");
      }
      return FutureBuilder(
        future: patientController
            .getHospitalsByCity(patientController.selectedCityId.value!),
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final items = s.data ?? [];
          return Obx(
            () => DropdownButton(
              value: patientController.selectedHospitalId.value,
              isExpanded: true,
              isDense: true,
              hint: const Text("Hastane Seçiniz"),
              items: items
                  .map((element) => DropdownMenuItem(
                        value: element.id,
                        child: Text(element.name ?? "Hastane Adı Yok"),
                      ))
                  .toList(),
              onChanged: (hospitalId) {
                patientController.selectedHospitalId.value = hospitalId;
              },
            ),
          );
        },
      );
    });
  }

  Widget _buildSelectBranchContainer() {
    return Obx(
      () {
        if (patientController.selectedHospitalId.value == null) {
          return const Text("Önce Hastane Seçimi Yapın");
        }
        return DropdownButton(
          value: patientController.selectedBranchId.value,
          isExpanded: true,
          isDense: true,
          hint: const Text("Bölüm Seçiniz"),
          items: patientController.branches
              .map((element) => DropdownMenuItem(
                    value: element.branchId,
                    child: Text(element.name ?? "Bölüm Adı Yok"),
                  ))
              .toList(),
          onChanged: (branchId) {
            patientController.selectedBranchId.value = branchId;
          },
        );
      },
    );
  }

  Widget _buildSelectDoctorContainer() {
    return Obx(() {
      if (patientController.selectedBranchId.value == null ||
          patientController.selectedHospitalId.value == null) {
        return const Text("Önce Bölüm Seçimi Yapın");
      }
      return FutureBuilder(
        future: patientController.getDoctorsByBranch(
          patientController.selectedBranchId.value!,
          patientController.selectedHospitalId.value!,
        ),
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final items = s.data ?? [];
          return Obx(
            () => DropdownButton(
              value: patientController.selectedDoctorId.value,
              isExpanded: true,
              isDense: true,
              hint: const Text("Doktor Seçiniz"),
              items: items
                  .map((element) => DropdownMenuItem(
                        value: element.userId,
                        child: Text(element.name ?? "Doktor Adı Yok"),
                      ))
                  .toList(),
              onChanged: (doctorId) {
                patientController.selectedDoctorId.value = doctorId;
              },
            ),
          );
        },
      );
    });
  }

  Widget _buildSelectedDoctorAvailabilityContainer() {
    return Obx(() {
      if (patientController.selectedDoctorId.value == null) {
        return const Text("Önce Doktor Seçimi Yapın");
      }

      return FutureBuilder(
        future: patientController.getDoctorAvailability(
          patientController.selectedDoctorId.value!,
        ),
        builder: (c, s) {
          return SfCalendar(
            view: CalendarView.week,
            initialDisplayDate: DateTime.now(),
            dataSource: AppointmentDataSource(s.data ?? []),
            minDate: DateTime.now(),
            maxDate: DateTime.now().add(const Duration(days: 7)),
            onTap: (details) async {
              if (details.targetElement == CalendarElement.calendarCell) {
                final date = details.date!;
                patientController.selectedDate = date;
              }
            },
          );
        },
      );
    });
  }
}
