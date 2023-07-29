String? requiredField(value) {
  if (value!.isEmpty) return 'الحقل مطلوب';

  return null;
}
