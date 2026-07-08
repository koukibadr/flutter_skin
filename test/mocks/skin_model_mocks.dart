// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_skin/models/skin_model.dart';

var skinModelMock = SkinModel(
  colors: const ColorScheme.light(
    primary: Color(0xFF6200EE),
    secondary: Color(0xFF03DAC6),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onSurface: Color(0xFF000000),
  ),
  id: 'mock_id',
  projectId: 'mock_project_id',
  isActive: true,
  version: 1,
  createdAt: DateTime.now(),
);
