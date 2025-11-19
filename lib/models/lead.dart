import 'package:hive/hive.dart';

// Status Enum - Keeping it simple strictly as per requirements
enum LeadStatus { New, Contacted, Converted, Lost }

@HiveType(typeId: 0)
class Lead extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String contact;

  @HiveField(3)
  LeadStatus status;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  final DateTime createdAt;

  Lead({
    required this.id,
    required this.name,
    required this.contact,
    this.status = LeadStatus.New,
    this.notes,
    required this.createdAt,
  });
}

// Manual Adapter to avoid running build_runner for this demo
class LeadAdapter extends TypeAdapter<Lead> {
  @override
  final int typeId = 0;

  @override
  Lead read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lead(
      id: fields[0] as String,
      name: fields[1] as String,
      contact: fields[2] as String,
      status: fields[3] as LeadStatus,
      notes: fields[4] as String?,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Lead obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contact)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.createdAt);
  }
}

// Need a separate adapter for the Enum
class LeadStatusAdapter extends TypeAdapter<LeadStatus> {
  @override
  final int typeId = 1;

  @override
  LeadStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LeadStatus.New;
      case 1:
        return LeadStatus.Contacted;
      case 2:
        return LeadStatus.Converted;
      case 3:
        return LeadStatus.Lost;
      default:
        return LeadStatus.New;
    }
  }

  @override
  void write(BinaryWriter writer, LeadStatus obj) {
    switch (obj) {
      case LeadStatus.New:
        writer.writeByte(0);
        break;
      case LeadStatus.Contacted:
        writer.writeByte(1);
        break;
      case LeadStatus.Converted:
        writer.writeByte(2);
        break;
      case LeadStatus.Lost:
        writer.writeByte(3);
        break;
    }
  }
}
