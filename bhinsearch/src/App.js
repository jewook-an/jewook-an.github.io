import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout/Layout';
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import ExperiencedUserDashboard from './pages/dashboard/ExperiencedUserDashboard';
import AdminDashboard from './pages/dashboard/AdminDashboard';
import RecruiterDashboard from './pages/dashboard/RecruiterDashboard';
import './App.css';

function App() {
  return (
    <Router>
      <Routes>
        {/* 레이아웃이 있는 페이지들 */}
        <Route path="/" element={<Layout><HomePage /></Layout>} />

        {/* 레이아웃이 없는 페이지들 (로그인, 회원가입) */}
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />

        {/* 대시보드 페이지들 (레이아웃 포함) */}
        <Route path="/dashboard" element={<Layout><ExperiencedUserDashboard /></Layout>} />
        <Route path="/dashboard/experienced" element={<Layout><ExperiencedUserDashboard /></Layout>} />
        <Route path="/dashboard/admin" element={<Layout><AdminDashboard /></Layout>} />
        <Route path="/dashboard/recruiter" element={<Layout><RecruiterDashboard /></Layout>} />

        {/* 추가 페이지들 (placeholder) */}
        <Route path="/positions" element={<Layout><div style={{padding: '2rem', textAlign: 'center'}}><h1>포지션 검색 페이지</h1><p>개발 예정</p></div></Layout>} />
        <Route path="/about" element={<Layout><div style={{padding: '2rem', textAlign: 'center'}}><h1>서비스 소개</h1><p>개발 예정</p></div></Layout>} />
        <Route path="/community" element={<Layout><div style={{padding: '2rem', textAlign: 'center'}}><h1>커뮤니티</h1><p>개발 예정</p></div></Layout>} />
      </Routes>
    </Router>
  );
}

export default App;
